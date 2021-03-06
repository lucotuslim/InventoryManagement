require 'spec_helper'

describe "User pages" do
 
 subject { page }
 describe "index" do
   let(:admin) {FactoryGirl.create(:admin)}
   before(:all) { 30.times { FactoryGirl.create(:admin) } }
   after(:all) {User.delete_all}
   before(:each) do
    sign_in admin 
    visit users_path
   end

   it {should have_selector('title',text:'Users listing')}
   it {should have_selector('h1',text: 'Users listin')}

  describe "pagination" do
   it {should have_selector('div.pagination')}
   it "should list each user" do
    User.paginate(page: 1).each do |user|
    page.should have_selector('li',text:admin.name)
    end 
   end
  end

   describe "delete links" do

      it { should have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

 end 



 describe "profile page" do
   let(:user) {FactoryGirl.create(:user) }
   before do
      sign_in user
      visit user_path(user)
   end 
   it {should have_selector('h1',text: user.name)}
   it {should have_selector('title',text: user.name)}
 end

 describe "signup page" do
   before { visit signup_path } 
   it { should have_selector('h1',text: 'Sign up') }
   it { should have_selector('title',text: 'Sign up') }
 end


 describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account"}

    describe "with invalid information" do
      it "should not create user" do
        expect {click_button submit }.not_to change(User,:count)
      end
    end

    describe "with valid information" do
      before do
       fill_in "Name", with: "Example User"
       fill_in "Email", with: "xxx@example.com"
       fill_in "Password", with: "foobar"
       fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
         expect {click_button submit}.to change(User,:count).by(1)
      end

       describe "after saving user" do
        before { click_button submit }
        let(:user) { User.find_by_email('xxx@example.com') }
        it { should_not have_selector('title', text: user.name) }
        it { should_not have_selector('div.alert.alert-success', text: 'Welcome') }
#        it { should_not have_link('Sign out', href: signout_path) }
        #it { should_not have_link('Sign in', href: signin_path)  }

       end
    end

 end

 describe "edit" do
  let(:user) {FactoryGirl.create(:user) }
  before do
   sign_in user
   visit edit_user_path(user) 
  end 

  describe "page" do
  it {should have_selector('h1',text: "Update your profile") }
  it {should have_selector('title',text: "Edit user") }
  it {should have_link('change',href: 'http://gravatar.com/emails') }
  end
   
  describe "with default information" do
    before {click_button "Save changes" }
    it {should_not have_content('error') }
  end
  describe "with valid information" do
   let(:new_name) {"New Name" }
   let(:new_email) {"xxx@xxx.com.sg" }
   before do
     fill_in "Name", with: new_name
     fill_in "Email", with: new_email
     fill_in "Password", with: user.password
     fill_in "Confirm Password", with: user.password
     click_button "Save changes"
   end
   it { should have_selector('title',text: new_name)}
   it { should have_selector('div.alert.alert-success')}
   it { should have_link('Sign out',href: signout_path)}
   specify {user.reload.name.should == new_name }
   specify {user.reload.email.should == new_email }

  end
 end
end
