class Admin::ManageUsersController < ApplicationController
  before_action :is_user_admin?
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to  admin_manage_users_path, notice: "#{@user.full_name}'s account was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      redirect_to  admin_manage_users_path, notice: "#{@user.full_name}'s account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :full_name)
  end

  def is_user_admin?
    current_user&.admin?
  end
end
