module ApplicationHelper
# helper which defines the title based upon whether or not the page provides a page title
  def full_title(page_title = "")
    base_title = "Steves App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

end
