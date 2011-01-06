module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Sample App from JPLethier"
    if @title.nil? or @title.empty?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
