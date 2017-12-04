class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thank you for signing up'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to login_url
      flash[:notice] = "You're not this user"
    else
      @user = User.find(params[:id])
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your info has been updated"
      redirect_to user_path(@user)
    else
      flash[:alert] = "review your form"
      render :edit
    end
  end

  def show
    require_login
    @user = current_user
  end

  private

  def user_params
      params.require(:user).permit(:name, :email,:avatar, :password, :password_confirmation)
    end
end
