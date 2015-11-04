class ProjectsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :my_project, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @projects = Project.all
    respond_with(@projects)
  end

  def show
    @blog_post = BlogPost.new(text: @project.unfinished_post) if @project.user == current_user
    @markdown_parser = markdown_parser(@project)
    respond_with(@project)
  end

  def new
    @project = Project.new
    respond_with(@project)
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      if params[:cover] && params[:cover][:image]
        binding.pry
        img = Image.create(image: params[:cover][:image], project: @project, name: @project.name)
        @project.update_attribute(:cover_image, img)
      end

      respond_with(@project)
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      respond_with(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private

  def my_project
    p = Project.find(params[:id])
    if p.user_id != current_user.id
      flash[:alert] = "You are not the owner of this project"
      redirect_to project_url(p)
    end
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :user_id, :category, :description, :thumbnail, :unfinished_post)
  end
end
