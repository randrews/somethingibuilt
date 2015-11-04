# Encoding: utf-8

class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:update, :destroy, :edit]
  before_action :set_project
  before_filter :my_project_and_image, except: [:index, :create]
  before_filter :my_project, only: [:index, :create]

  respond_to :html, :json

  def index
    @images = @project.images
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      flash[:notice] = "Image added"
      redirect_to project_images_url(@project)
    else
      flash[:alert] = "Couldn't add this image: #{@image.errors.full_messages.to_sentence}"
      redirect_to project_images_url(@project)
    end
  end

  def update
    if @image.update(image_update_params)
      if params[:cover_image] && @project.cover_image != @image
        @project.update_attribute :cover_image, @image
      elsif !params[:cover_image] && @project.cover_image == @image
        @project.update_attribute :cover_image, nil
      end

      flash[:notice] = "Image updated"
      redirect_to project_images_url(@project)
    else
      flash[:alert] = "Couldn't update this image: #{@image.errors.full_messages.to_sentence}"
      render 'edit'
    end
  end

  def destroy
    if @project.cover_image == @image
      @project.update_attribute :cover_image, nil
    end

    @image.destroy
    flash[:notice] = "Image deleted"
    redirect_to project_images_url(@project)
  end

  private

  def my_project
    p = Project.find(params[:project_id])
    if p.user_id != current_user.id
      flash[:alert] = "You are not the owner of this project"
      redirect_to project_path(@project)
    end
  end

  def my_project_and_image
    p = Project.find(params[:project_id])
    i = Image.find(params[:id])

    if p.user_id != current_user.id || i.project != p
      flash[:alert] = "You are not the owner of this image"
      redirect_to project_url(p)
    end
  end

  def set_image
    @image = Image.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def image_update_params
    params.require(:image).permit(:name)
  end

  def image_params
    p = params.require(:image).permit(:name, :image)
    p[:project_id] = params[:project_id]
    p
  end
end
