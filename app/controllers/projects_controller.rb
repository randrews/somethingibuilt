class ProjectsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :my_project, only: [:edit, :update, :destroy]
  helper_method :markdown_parser
  respond_to :html

  def index
    @projects = Project.all
    respond_with(@projects)
  end

  def show
    @blog_post = BlogPost.new(text: @project.unfinished_post) if @project.user == current_user
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

  def markdown_parser
    return @parser if @parser.present?

    renderer = Redcarpet::Render::XHTML.new(escape_html: true,
                                            link_attributes: { rel: 'nofollow' },
                                            prettify: true,
                                            safe_links_only: true,
                                            hard_wrap: true)

    @parser = Redcarpet::Markdown.new(renderer,
                                      autolink: true,
                                      no_intra_emphasis: true,
                                      fenced_code_blocks: true)

    @parser
  end

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
