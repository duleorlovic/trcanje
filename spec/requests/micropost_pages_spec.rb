require 'spec_helper'

describe "MicropostPages" do
  subject { page }
  let(:user) { Factory.create(:users) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid info" do
      it "should not create micropost" do
        expect { click_button "Submit" }.should_not change(Micropost,:count)
      end
    end
    describe "with filled in data" do
      before { fill_in 'micropost_content',with:"cao" }
      it "should create a micropost" do
        expect { click_button "Submit" }.should change(Micropost,:count).by(1)
      end
    end
  end
end
