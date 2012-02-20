require 'spec_helper'

describe Users do
  before {@user = Users.new(name:"dule orlovic",email:"orlovics@eunet.rs", password:"foobar", password_confirmation:"foobar")}
  subject {@user}

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }
  it { should respond_to :remember_token }
  it { should respond_to :admin }

  it { should be_valid } 
  it { should_not be_admin }
  
  describe "with admin attribute set to true" do
    before { @user.toggle!(:admin) }
    it { should be_admin}
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank}
  end
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { Users.find_by_email(@user.email) }
    
    describe "with valid password" do
      it {should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it {should_not == user_for_invalid_password}
      specify {user_for_invalid_password.should be_false}
    end
  end
  describe "password to short" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should be_invalid }
  end


  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " "} 
    it { should_not be_valid }
  end

  describe " when password doesn't match confirmation " do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    invalid_addresses.each do |invalid|
      before {  @user.email = invalid }
      it {should_not be_valid}
    end
  end

  describe "when adres is already taken" do
    before do 
      same_user = @user.dup
      same_user.email = @user.email.upcase
      same_user.save
    end
    it {should_not be_valid}
  end
  
 
end
