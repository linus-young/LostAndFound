require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button 'Sign in'}

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link 'Home'}
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      it { should have_title(user.name) }
      # it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link 'Sign out' }
        it { should have_link('Sign in') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do

      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in 'Email',    with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end

          describe "when signing in again" do
            before do
              click_link 'Sign out'
              log_in user
            end

            it "should render the default (profile) page" do
              expect(page).to have_title(user.name)
            end
          end
        end
      end

      # When user wants to update profile, create or destroy lost_item,
      # he should sign in first.
      shared_examples_for "need to sign in first" do
        specify { expect(response).to redirect_to(signin_path) }
      end

      describe "in the Users controller" do

        # describe "visiting the user index" do
        #   before { visit users_path }
        #   it { should have_title('Sign in') }
        # end

        describe "visiting the user's profile" do
          before { visit user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          it_should_behave_like "need to sign in first"
        end
      end

      describe "in the LostItems controller" do

        describe "visiting the new lost_item page" do
          before { visit new_user_lost_item_path(user)}
          it { should have_title('Sign in') }
        end

        describe "visiting the edit page" do
          before do
            visit edit_user_lost_item_path(user, FactoryGirl.create(:lost_item))
          end
          it { should have_title('Sign in') }
        end

        describe "submitting to the create action" do
          before { post user_lost_items_path(user) }
          it_should_behave_like "need to sign in first"
        end

        describe "submitting to the destroy action" do
          before do
            delete user_lost_item_path(user, FactoryGirl.create(:lost_item))
          end
          it_should_behave_like "need to sign in first"
        end
      end
    end

    describe "for signed_in users" do
      let(:user) { FactoryGirl.create(:user) }
      before { log_in user }

      describe "when attempting to visit register page" do
        before { visit register_path }
        it { should_not have_title('Register') }
      end

      describe "when attempting to visit signin page" do
        before { visit signin_path }
        it { should_not have_title('Sign in') }
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user)}
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      before { log_in user, no_capybara: true }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { log_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end

end
