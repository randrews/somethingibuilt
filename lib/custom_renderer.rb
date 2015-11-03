# Encoding: utf-8

class CustomRenderer < Redcarpet::Render::HTML
  attr_accessor :project

  def image link, title, alt_text
    tag = lambda do |link, title, alt_text|
      return "<img src=\"#{link}\" alt=\"#{alt_text}\" title=\"#{title}\"/>"
    end

    if project.nil?
      return tag.call(link, title, alt_text)
    end

    if link =~ /image_(\d+)/
      img = Image.find($1.to_i)
      if img && img.project == project
        img_tag = tag.call(img.image.url, title || img.name, alt_text || img.name)
        return "<a href=\"#{img.image.url}\" target=\"_blank\">#{img_tag}</a>"
      end
    elsif link =~ /thumb_(\d+)/
      img = Image.find($1.to_i)
      if img && img.project == project
        img_tag = tag.call(img.image.url(:thumb), title || img.name, alt_text || img.name)
        return "<a href=\"#{img.image.url}\" target=\"_blank\">#{img_tag}</a>"
      end
    else
      return tag.call(link, title, alt_text)
    end
  end
end
