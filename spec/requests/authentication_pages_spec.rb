require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}
  
  describe "authorization" do
    describe "for non signed users" do
      let(:user) { Factory(:users) }

      describe "in the users controler" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
         # it { should have_selector('title',text:'Sign in') }
        end
        describe "submit the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end
  describe "signin page" do
    before { visit signin_path }
    it { should have_selector('h1',text:"Sign in") }

    describe "with invalid infromation" do
      before {click_button "Sign in"}
      it {should have_selector('div.flash.error',test:"Invalid") }
    end

    describe "with valid info" do
      let(:user) {FactoryGirl.create(:users) }
      before do
        fill_in "Email", with:user.email
        fill_in "Password", with:user.password
        click_button "Sign in"
      end

      it { should have_link('Profile',href:user_path(user)) }
      it { should have_link('Settings',href:edit_user_path(user)) }
      it { should have_link('Sign out', href:signout_path) }
      it { should_not have_link('Sign in', href:signin_path) }
    end
  end

 

end
