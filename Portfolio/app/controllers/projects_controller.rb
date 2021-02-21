# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def react
    @react_projects = Project.react
  end

  def new
    @project = Project.new
  end

  def show; end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: 'New project created!'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to project_path, notice: 'Project updated!'
    else
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project deleted!'
    else
      render 'show'
    end
  end

  ### Testing globbing
  # def missing
  #   render 'new'
  # end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :subtitle, :body)
  end
end
