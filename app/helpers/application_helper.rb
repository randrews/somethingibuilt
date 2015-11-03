require 'custom_renderer'

module ApplicationHelper
  def markdown_parser project
    return @parser if @parser.present?

    renderer = CustomRenderer.new(escape_html: true,
                                  link_attributes: { rel: 'nofollow' },
                                  prettify: true,
                                  safe_links_only: true,
                                  hard_wrap: true)

    renderer.project = project

    @parser = Redcarpet::Markdown.new(renderer,
                                      autolink: true,
                                      no_intra_emphasis: true,
                                      fenced_code_blocks: true)
  end
end
