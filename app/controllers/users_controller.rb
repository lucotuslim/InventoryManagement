class UsersController < ApplicationController
  skip_before_filter :require_user, :only => [:create,:new]

#  before_filter :signed_in_user, only: [:index,:edit, :update,:destroy]
#  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_or_current_user , :only => [:edit, :update,:destroy]
  before_filter :admin_user , :only => :index
 
   def show
    @user = User.find(params[:id])
  end

  def destroy

    User.find(params[:id]).destroy
#    flash[:success]="User destroyed."

    respond_to do |format|
      format.html { redirect_to(users_url,:notice =>"User destroyed") }
      format.js
    end

  end

  def index
    @search = User.search(params[:search])  
    @users=@search.paginate(page: params[:page])
  end

  def new
  @user = User.new
  end

  def edit
   @user=User.find(params[:id])
  end  
 
  def update
    @user=User.find(params[:id])
    if !params[:user][:password]==''
         @user.updating_password = true
    end
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
#      sign_in @user
      redirect_to @user
    else
    render 'edit'
    end
  end

  def create 
   @user = User.new(params[:user]) 
   @user.updating_password = true
   if @user.save
    #sign_in @user
    flash[:success] = "Successfully create account, but need admin to approve"
    #redirect_to @user
    redirect_to root_path
   else
     render 'new'
   end
  end

 private 
#    def signed_in_user
#     unless signed_in? 
#      store_location
#      redirect_to signin_path, notice: "Please sign in." unless signed_in?
#     end
#    end

   def admin_or_current_user
      @user = User.find(params[:id])
     unless current_user == @user || current_user.admin   
        flash[:notice] = "You need to be admin in order to edit other user"
        redirect_to(root_path)
     end
   end

    def correct_user
      @user = User.find(params[:id])
      current_user == @user
    end
  
  def admin_user
    unless current_user.admin
       flash[:notice] = "You need to be admin in order to edit other user"
       redirect_to(root_path)
    end
  end
end
