class AttendancesController < ApplicationController

  def index
    @students = current_user.grade_levels.first.users.student
    @chosen_date = params[:date].to_date
    if @chosen_date
      start_of_week = @chosen_date&.beginning_of_week
      @current_week_days = (0..4).map { |increment| (start_of_week + increment) }
      @attendances = Attendance.where(date: @current_week_days, user_id: @students.ids)
    else 
      start_of_week = Date.today.beginning_of_week
      @current_week_days = (0..4).map { |increment| (start_of_week + increment) }
      @attendances = Attendance.where(date: @current_week_days, user_id: @students.ids)
    end
  end

  def new
    @attendance = Attendance.new
    @grade_level = GradeLevel.find(params[:grade_level_id])
    @students = @grade_level.users
  end

  def create
    date = attendance_params[:date]
    @grade_level = GradeLevel.includes(:users).find_by(id: attendance_params[:grade_level])
    @students = @grade_level.users
    Attendance.transaction do
      @students.each do |student|
      status = attendance_params["student_id_#{student.id}_status"]
      @attendance = Attendance.create!(user_id: student.id, date: date, status:, grade_level: @grade_level)
      end
      redirect_to attendances_path, notice: "Attendance was successfully recorded." 
    rescue
      @attendance
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def attendance_params
    params.require(:attendance).permit!
  end

  def current_week_days
    (0..4).map {|day| (Date.today.beginning_of_week + day).to_s }
  end
end
