atom_feed :language => 'fr' do |feed|
  feed.title "RailsFrance » Evénéments"
  feed.updated @events.first.created_at

  @events.each do |item|
    feed.entry(item) do |entry|
      entry.url event_url(item)
      entry.title item.title
      entry.content :type => 'xhtml' do |html|
        html.p "Ville -- #{item.city}"
	html.p "Lieu -- #{item.street}"
	html.p "Date -- #{item.date.strftime("%d-%m-%Y à %H:%M")}"
	html.p item.description
      end

      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
          author.name item.user_username
        end
    end
  end
end
