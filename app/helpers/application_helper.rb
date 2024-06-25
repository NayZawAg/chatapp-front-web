module ApplicationHelper
  def full_title(page_title)
    base_title = "MiMo App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def render_html(content)
    sanitize(content, tags: %w(p span div br strong em a blockquote s ul ol li), attributes: %w(href class style))
  end
end
