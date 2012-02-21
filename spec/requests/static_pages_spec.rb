require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do

    it "should have the title 'Home'" do
      visit root_path
      page.should have_selector('title', text: "Home")
    end
    describe "for signed-in users" do
      let(:user) { Factory.create(:users) }
      let(:m) { user.microposts.create content:"d"}
      before do
        user.microposts.create content:"a"
        sign_in user
        visit  root_path 
      end
      it " should render users feed" do
        user.feed.each do |item|
          page.should have_selector('tr',text:item.content)
        end
      end
      describe "delete microposts" do
        before do
          sign_in user
          visit root_path
        end
        it { page.should have_link('delete',href:micropost_path(user.microposts.first))}

        it "should be able to delete micropost" do 
          expect { click_link('delete') }.to change(user.microposts,:count).by(-1)
        end
      end
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1', text: 'Help')
    end

    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title',
                        text: "Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About'" do
      visit about_path
      page.should have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      visit about_path
      page.should have_selector('title',
                    text: "About Us")
    end
  end

  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                    text: "Contact")
    end
  end
end
