module TagsHelper
  def colorize_tags(tags)
    colors = %w[blue brown red]
    raw(
        tags.collect do |tag|
          content_tag :div, :class => "#{colors.sample}" do
            link_to("#{ tag.name }", questions_path(:tag => tag.name), { :class => "name" }) +
              content_tag(:p, "#{ tag.count }", :class => "count") +
              "\n"
          end
        end.join
        )
  end
end
