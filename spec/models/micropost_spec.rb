require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:users) }
  before { @micropost = user.microposts.build(content:"CAO") }
  subject { @micropost }

  it { should respond_to(:users_id) }
  it { should respond_to(:content) }
  it { should respond_to(:users) }
  its(:users) { should ==user }

  it { should be_valid }

  describe "when user id is not present" do
    before { @micropost.users_id = nil }
    it { should_not be_valid }
  end
  describe "when content is emmpy" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end
  describe "when content is to large" do
    before { @micropost.content = "a"*141 }
    it { should_not be_valid }
  end

end
