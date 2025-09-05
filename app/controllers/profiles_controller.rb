# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_user

  def show
    return unless current_user.admin? || current_user.teacher?
    @school_year = SchoolYear.first
  end

  def session_details
    @grade_level = GradeLevel.includes(:school_terms)&.find(params[:grade_level])
    @school_terms = @grade_level.school_terms
    @subjects = @grade_level.subjects
    @examinations = Examination.where(subject_id: @subjects.ids, user_id: @user.id)
  end


  private

  def assign_user
    @user = (current_user.admin? || current_user.teacher?) ? User.find(params[:id]) : current_user
  end
end
