# frozen_string_literal: true

class AttendancesController < ApplicationController
  def index
    school_year = SchoolYear.includes(grade_levels: :users).find_by(id: params[:school_year]) || SchoolYear.first
    @grade_levels = school_year.grade_levels.includes(users: :attendances)
    students = school_year.grade_levels.first.users.student
    start_of_week = params[:date]&.to_date ? params[:date].to_date.beginning_of_week : Date.today.beginning_of_week
    @current_week_days = (0..4).map { |increment| (start_of_week + increment) }
    @attendances = Attendance.where(date: @current_week_days, user_id: students&.ids)
  end

  def new
    @attendance = Attendance.new
    @grade_level = GradeLevel.find(params[:grade_level_id])
    @students = @grade_level.users.student
  end

  def create
    date = attendance_params[:date]
    @grade_level = GradeLevel.includes(:users).find_by(id: attendance_params[:grade_level])
    @students = @grade_level.users.student
    Attendance.transaction do
      @students.each do |student|
      status = attendance_params["student_id_#{student.id}_status"]
      @attendance = Attendance.create!(user_id: student.id, date: date, status:, grade_level: @grade_level)
      end
    rescue
      @attendance = Attendance.new
      @grade_level = GradeLevel.find(attendance_params[:grade_level])
      @students = @grade_level.users.student
      return render :new, status: :unprocessable_entity
    end
    redirect_to attendances_path, notice: "Attendance for #{date} was successfully recorded."
  end

  def update
  end

  private

  def attendance_params
    params.require(:attendance).permit!
  end

  def current_week_days
    (0..4).map { |day| (Date.today.beginning_of_week + day).to_s }
  end
end
