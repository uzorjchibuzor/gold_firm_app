# frozen_string_literal: true

class Admin::ManageUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_admin?
  before_action :set_current_school_session, only: [ :enroll_user ]

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to  admin_manage_users_path, notice: "#{@user.full_name}'s account has been successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def disable_user
    @user = User.find(params[:user])
    if @user.update(disabled: true)
       redirect_to admin_manage_users_path, notice: "#{@user.full_name}'s account has been disabled."
    else
       redirect_to admin_manage_users_path, notice: "#{@user.full_name}'s account could not be disabled."
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def enroll_user
    begin
      desired_grade_level_id = @current_session_year.grade_levels
                                                    .find_or_create_by!(
                                                      title: params[:current_class])
                                                    .id

      set_enrolled_class(desired_grade_level_id, @current_session_year.id)
      redirect_to admin_manage_users_path, notice: "#{@user.full_name} has been successfully enrolled."
    rescue ActiveRecord::RecordInvalid
      redirect_to admin_manage_users_path, notice: "An error occured, please contact system admin."
    end
  end

  def index
    @users = User.student
  end

  def new
    @user = User.new
  end

  def unenroll_user
    @user = User.find(params[:user_id])
    class_subcription = @user.yearly_grade_levels.find_by(user_id: params[:user_id], school_year_id: params[:school_year_id])
    class_subcription.destroy
    redirect_to show_profile_path(id: @user.id), notice: "#{@user.full_name} has been successfully unenrolled."
  end

  def update
    @user = User.find(params[:id])
    if @user&.update(user_params)
      redirect_to admin_manage_users_path, notice: "#{@user.full_name}'s account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end





  private
  def is_user_admin?
      redirect_to root_path, notice: "You must be an admin to access the requested page" if !(current_user.admin?)
  end

  def set_current_school_session
    @current_session_year ||= SchoolYear.includes(:grade_levels).first_or_create(start_year: 1.year.ago.year, end_date: 0.year.ago.year)
  end

  def set_enrolled_class(level_id, school_year_id)
    @user = User.find(params[:user_id])
    @user.yearly_grade_levels.create!(grade_level_id: level_id, school_year_id: school_year_id)
    # @user = User.find(params[:user_id])
    # @user.update(current_class: User::ALLOWED_CLASSES[(params[:current_class]).to_i][0])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :full_name, :current_class)
  end
end
