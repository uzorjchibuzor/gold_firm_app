# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_user

  def show
  end

  def session_details
    @grade_level = GradeLevel.includes(:school_terms)&.find(params[:grade_level])
    @examinations = @grade_level.examinations.where(user_id:  @user.id)
  end


  private

  def assign_user
    @user = current_user.admin? ? User.find(params[:id]) : current_user
  end
end
