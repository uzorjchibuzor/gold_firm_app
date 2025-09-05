# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :is_user_admin_or_teacher?
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
        begin
          Attendance.create!(user_id: student.id, date: date, status:, grade_level: @grade_level)
        rescue ActiveRecord::RecordInvalid => e
          @attendance = Attendance.new
          flash.now[:alert] = "Error Saving attendance for #{student.full_name}: #{e.record.errors.full_messages.join(', ')}"
          render :new, status: :unprocessable_entity

        rescue => e
          @attendance = Attendance.new
          flash.now[:alert] = "An unexpected error occured: #{e.message}}"
          render :new, status: :unprocessable_entity
        end
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

  def current_week_days
    (0..4).map { |day| (Date.today.beginning_of_week + day).to_s }
  end
end
