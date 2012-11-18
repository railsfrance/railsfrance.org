module ApplicationHelper
  def feed(title, link)
    @feeds = {}
    @feeds[link] = title
  end

  def sanitize(html)
    Sanitize.clean(markdown(html), elements: %w[p br])
  end
  
  def ie_tag(name=:body, attrs={}, &block)
    attrs.symbolize_keys!
    haml_concat("<!--[if lt IE 7]> #{ tag(name, add_class('ie6', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 7]>    #{ tag(name, add_class('ie7', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 8]>    #{ tag(name, add_class('ie8', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if gt IE 8]><!-->".html_safe)
    haml_tag name, attrs do
      haml_concat("<!--<![endif]-->".html_safe)
      block.call
    end
  end
  
  def ie_html(attrs={}, &block)
    ie_tag(:html, attrs, &block)
  end
  
  def class_for_tab(name)
    name.to_s == controller.controller_name ? "selected" : ""
  end
  
  private
  
  def add_class(name, attrs)
    classes = attrs[:class] || ''
    classes.strip!
    classes = ' ' + classes if !classes.blank?
    classes = name + classes
    attrs.merge(class: classes)
  end

end