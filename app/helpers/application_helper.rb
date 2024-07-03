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
    return "" if content.nil?
  
    # Sanitize the content
    content = sanitize(content, tags: %w(p span div br strong em a blockquote s ul ol li), attributes: %w(href class style))
  
    # Ensure all lines are wrapped in <p> tags
    wrapped = content.split("\n").map { |line| "<p>#{line}</p>" }.join("\n")
    wrapped.html_safe

  end

end
