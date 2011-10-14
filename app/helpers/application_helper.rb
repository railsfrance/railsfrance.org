module ApplicationHelper
  def feed(title, link)
    @feeds = {}
    @feeds[link] = title
  end

  def sanitize(html)
    Sanitize.clean(markdown(html), :elements => %w[p br])
  end

  def class_for_tab(name)
    name.to_s == controller.controller_name ? {class: "selected"} : {class: ""}
  end
end

