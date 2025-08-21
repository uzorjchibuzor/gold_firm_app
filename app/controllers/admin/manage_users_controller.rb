class Admin::ManageUsersController < ApplicationController
  before_action :is_user_admin?
  before_action :set_current_school_session, only: [ :enroll_user ]

  def edit
    @user = User.find_by_id(params[:id])
  end

  def enroll_user
    enrollment = @current_session_year.enrollments.create(user_id: params[:user_id])
    set_enrolled_class
    redirect_to admin_manage_users_path, notice: "#{@user.full_name} has been successfully enrolled."
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to  admin_manage_users_path, notice: "#{@user.full_name} has been successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def unenroll_user
    @user = User.find(params[:user_id])
    enrollment = Enrollment.find_by(user_id: params[:user_id], school_year_id: params[:school_year_id])
    enrollment.destroy
    redirect_to show_profile_path(id: @user.id), notice: "#{@user.full_name} has been successfully unenrolled."
  end

  def update
    @user = User.find_(params[:id])
    if @user&.update(user_params)
      redirect_to  admin_manage_users_path, notice: "#{@user.full_name}'s account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end





  private
  def is_user_admin?
      return redirect_to new_user_session_path, notice: "You must be an admin to access the requested page" if !current_user
      redirect_to root_path, notice: "You must be an admin to access the requested page" if !(current_user.admin?)
  end

  def set_current_school_session
    @current_session_year ||= SchoolYear.first
  end

  def set_enrolled_class
    @user = User.find(params[:user_id])
    @user.update(current_class: User::ALLOWED_CLASSES[(params[:current_class]).to_i][0])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :full_name, :current_class)
  end
end
