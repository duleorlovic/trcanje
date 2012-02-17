require 'spec_helper'

describe "StaticPages" do
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #get static_pages_index_path
      #response.status.should be(200)
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end

    it "should have help page" do 
      visit '/static_pages/help'
      page.should have_content('Help')
    end

    it 'should have the right title' do
      visit '/static_pages/home'
      page.should have_selector('title',:text=> "Home")
    end
  end
end
