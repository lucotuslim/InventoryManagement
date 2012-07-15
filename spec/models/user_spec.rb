require 'spec_helper'
require 'authlogic/test_case'
describe User do

activate_authlogic 

 before do 
  @user = User.new(:name=>"Chee Yong", :email=>"cheeyong.lim@cbsinteractive.com",
                   :password=>"password",:password_confirmation=>"password")
 end
 subject { @user }
 it { should respond_to(:name)} 
 it { should respond_to(:email)}
# it { should respond_to(:password_digest) }
 it { should respond_to(:password) }
 it { should respond_to(:password_confirmation) }
 it { should respond_to(:admin)}
# it { should respond_to(:authenticate) }
# it { should respond_to(:remember_token) }
 it { should be_valid } 
 it { should_not be_admin} 
 describe "with admin attribute set to true" do
   before {@user.toggle!(:admin)}
   it { should be_admin}
 end
 describe "password blank" do
   before { @user.password = @user.password_confirmation = " "   } 
   it {should_not be_valid}
 end

 describe  "missmatch password" do
  before {@user.password_confirmation = "missmatch" }
  it {should_not be_valid}
 end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

 describe "When name not present" do
   before do
    @user.name=" "
    @user.email="cheeyong.lim@cbsinteractive.com"
   end
    it {should_not be_valid }
 end

 describe "When email not present" do
   before do
    @user.name="lim"
    @user.email=""
   end
    it {should_not be_valid }
 end

 describe "when email format is invalid" do
  it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
 end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "duplicate email "  do
   before do 
     user_with_same_email=@user.dup
     user_with_same_email.save
   end
   it { should_not be_valid} 
  end


#  describe "return value of authenticate method" do
#   before do
#     @user.save
#     @user_session = UserSession.create(@user)
#   end  
#   let(:found_user) {User.find_by_email(@user.email) }
#     describe "with valid password" do
#       it { should == found_user.authenticate(@user.password) }
#       it { should == current_user }
#     require_user 
#     response.should_not be_redirect 
#     end
#
#     describe "with invalid password" do
#       let(:user_for_invalid_password) {found_user.authenticate("invalid") } 
#       it { should_not == user_for_invalid_password}
#       specify {user_for_invalid_password.should be_false }
#     end

 # end

# describe "remember token" do
#   before {@user.save} 
#   its(:remember_token) {should_not be_blank}
# end

end
