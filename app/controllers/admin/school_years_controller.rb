# frozen_string_literal: true

class Admin::SchoolYearsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_admin?
  def create
    @school_year = SchoolYear.build(school_year_params)
    if @school_year.save
      redirect_to admin_school_years_path, notice: "School Year created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  def edit
  end

  def index
    @school_years = SchoolYear.includes(:grade_levels).all
  end

  def new
    @school_year = SchoolYear.new
  end

  def update
  end

  private

  def school_year_params
    params.require(:school_year).permit(:start_year, :end_year)
  end
end
