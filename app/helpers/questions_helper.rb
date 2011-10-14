module QuestionsHelper
  def sortable(title = nil, column)
    title ||= column.titleize
    css_class = column == sort_column ? "#{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'desc' ? 'asc' : 'desc'
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def pluralize_word(count, singular, plural = nil)
    ((count == 1 || count == '1') ? singular : (plural || singular.pluralize))
  end

  def tag_box(css_class, tags)
    content_tag :div, :class => css_class do
      raw(
          tags.collect do |tag|
            link_to(tag.name, questions_path(:tag => tag.name))
          end.join
          )
    end
  end
end
