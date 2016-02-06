class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
  
  if @user.save
    sign_in @user
    flash[:success] = "Добро пожаловать в Twitter! Вы успешно зарегистрировались!"
    redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def index
   @users = User.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
     @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Профайл успешно обновлен!"
        redirect_to @user
      else 
        render "edit"
      end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
  # def signed_in_user
  #   if not signed_in?
  #     redirect_to signin_url, notice: "Пожалуйста, сначала войдите"
  #   end
  # end
  
  def correct_user
      @user = User.find(params[:id])
      if not current_user?(@user)
        redirect_to root_url, notice: "У вас нет прав для данного действия!"
      end
  end
  
  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end
end
