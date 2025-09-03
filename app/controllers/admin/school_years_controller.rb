# frozen_string_literal: true

class Admin::SchoolYearsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_admin?
  def create
  end

  def destroy
  end

  def edit
  end

  def index
  end

  def new
  end

  def update
  end
end
