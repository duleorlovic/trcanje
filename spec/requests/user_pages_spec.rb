require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "edit" do
    let(:user) { FactoryGirl.create(:users)}
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',text:"Edit") }
      it { should have_link('change',href:'http://gravatar.com/emails') }
    end
    describe "with invalid inf" do
      let(:error) { 'error'}
      before { click_button "Update" }

      it { should have_content(error) }
    end

  end


  describe "signup page" do
      before { visit signup_path }
  
      it { should have_selector('h1',    text: 'Sign up') }
      it { should have_selector('title', text: 'Sign up') }
      
      describe "with valid information" do
        before do 
          fill_in "Name", with:"dusan orlovic"
          fill_in "Email",with:"orlovics@euner.rs"
          fill_in "Password",with:"foobar"
          fill_in "Confirmation",with:"foobar"
        end
        it "should create user" do
          expect {click_button "Sign up"}.to change(Users,:count).by(1)
        end
      end
    end
  describe "profile page" do
    let(:users) { FactoryGirl.create(:users)}
    before { visit user_path(users) }

    it {should have_selector('h1', text:users.name) }
   # it {should have_selector('title', text:users.name) }
  end
end
