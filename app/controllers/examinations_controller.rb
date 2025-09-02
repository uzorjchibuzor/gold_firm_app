# frozen_string_literal: true

class ExaminationsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_admin_or_teacher?

  def create
    @examination = Examination.build(exam_params)
    @examination.creator = current_user
    if @examination.save
      redirect_to examinations_path, notice: "Exam score for created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @examination = Examination.find_by(id: params[:id])
  end

  def index
    @examinations = Examination.includes(grade_level: :school_year).includes(:user, :subject, :school_term).where(creator_id: current_user.id)
  end

  def new
    @examination = Examination.new(exam_params)
  end

  def show
  end

  def update
    @examination = Examination.find_by(id: params[:id])
    @examination.updater_id = current_user.id
    if @examination.update(exam_params)
      redirect_to examinations_path, notice: "Exam score for updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def exam_params
    params.require(:examination).permit(:exam_type, :school_term_id, :subject_id, :grade_level_id, :user_id, :score)
  end
end
