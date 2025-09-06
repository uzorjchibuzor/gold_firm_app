# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :is_user_admin_or_teacher?
  before_action :set_creation_params, only: [ :create ]
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
    Attendance.transaction do
      unless create_attendances(date)
        return render :new, status: :unprocessable_entity
      end
    end
    redirect_to attendances_path(date: date), notice: "Attendance for #{date} was successfully recorded."
  end

  def update
  end

  private

  def attendance_params
    params.require(:attendance).permit!
  end

  def create_attendance_for_student(student, date)
    status =  attendance_params["student_id_#{student.id}_status"]
    begin
      Attendance.create!(user_id: student.id, date: date, status:, grade_level: @grade_level)
      true
    rescue ActiveRecord::RecordInvalid => e
      handle_attendance_error(student, e.record.errors.full_messages.join(", "))
      false
    rescue => e
      handle_other_error(e.message)
      false
    end
  end

  def create_attendances(date)
    @students.each do |student|
      return false unless create_attendance_for_student(student, date)
    end
  end

  def handle_attendance_error(student, error_message)
    @attendance = Attendance.new
    flash.now[:alert] = "Error Saving attendance for #{student.full_name}: #{error_message}"
  end

  def handle_other_error(error_message)
    @attendance = Attendance.new
    flash.now[:alert] = "An unexpected error occured: #{error_message}}"
  end

  def set_creation_params
    @grade_level = GradeLevel.includes(:users).find_by(id: attendance_params[:grade_level])
    @students = @grade_level.users.student
  end
end
