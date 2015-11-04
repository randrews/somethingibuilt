class BlogPost < ActiveRecord::Base
  belongs_to :project

  validates :project_id, presence: true
  validates :text, presence: true

  before_save :clean_newlines

  def preview_text
    return @preview_text if @preview_text

    if text =~ /(.*?)\n/
      @preview_text = $1
    else
      @preview_text = text
    end
  end

  def clean_newlines
    self.text = text.gsub("\r\n","\n")
  end
end
