require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}
  
  describe "authorization" do
    describe "for non signed users" do
      let(:user) { Factory(:users) }

      describe "in the Microposts controler" do
        describe "submitting to create action " do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) } 
        end
        describe "submitting to the destroy action" do
          before do
            micropost = user.microposts.create(content:"a")
            delete micropost_path(micropost)
          end
          specify { response.should redirect_to(signin_path) } 
        end
      end
      describe "in the users controler" do
        describe "visiting user index" do
          before { visit user_path }
          it { should have_selector('title',text:"Sign in") }
        end

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title',text:'Sign in') }
          describe "after signin" do
            before { sign_in user}
            it {should have_selector('title',text:"Edit")}
          end
        end
        describe "submit the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
    describe "for signed users" do
      let(:user) { FactoryGirl.create(:users) }
      let(:wrong_user) { FactoryGirl.create(:users,email:"wrog@example.com") }
      before { sign_in user  }
      
      describe "visit users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should have_selector('title',text:'Home')}
      end
      
      describe "submiting put request to users#update action" do
        before { put user_path(wrong_user) }
        it { request.should redirect_to(root_path) }
      end

      describe "visit user/new page " do
        before { visit new_user_path }
        it { should have_selector('title',text:'Home') }
      end
      describe "submit user/new " do
        before { post user_path }
        it { response.should redirect_to(root_path)}
      end

      describe "as no-admin user" do
        let(:non_admin) { FactoryGirl.create(:users) }

        before { sign_in non_admin }

        describe "submitting a DELETE request to the Users#destroy action" do
                before { delete "/user/3" }
                specify { response.should redirect_to(root_path) }        
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

    it { should_not have_link('Users') }
    it { should_not have_link('Profile') }
    it { should_not have_link('Settings') }
    describe "with valid info" do
      let(:user) {FactoryGirl.create(:users) }
      
      before {sign_in user }

      it { should have_link('Users',href:user_path) }
      it { should have_link('Profile',href:user_path(user)) }
      it { should have_link('Settings',href:edit_user_path(user)) }
      it { should have_link('Sign out', href:signout_path) }
      it { should_not have_link('Sign in', href:signin_path) }
    end
  end
end
