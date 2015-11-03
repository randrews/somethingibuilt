# Encoding: utf-8

class BlogPostsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_blog_post, only: [:show, :update, :destroy]
  before_filter :my_project, only: [:create, :update, :destroy]

  respond_to :html, :json

  def create
    @project = Project.find(params[:project_id])
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      flash[:notice] = "Post added"
      @project.update_attribute(:unfinished_post, '')
      redirect_to project_url(params[:project_id])
    else
      @project.update_attribute(:unfinished_post, blog_post_params[:text])
      flash[:alert] = "Couldn't add this blog post: #{@blog_post.errors.full_messages.to_sentence}"
      redirect_to project_url(params[:project_id])
    end
  end

  def update
    if @blog_post.update(blog_post_params)
      respond_with(@blog_post)
    else
      render 'edit'
    end
  end

  def destroy
    @blog_post.destroy
    flash[:notice] = "Post deleted"
    redirect_to project_url(params[:project_id])
  end

  private

  def my_project
    p = Project.find(params[:project_id])
    if p.user_id != current_user.id
      flash[:alert] = "You are not the owner of this project"
      redirect_to project_url(p)
    end
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    p = params.require(:blog_post).permit(:text)
    p[:project_id] = params[:project_id]
    p
  end
end
