atom_feed :language => 'fr' do |feed|
  feed.title "RailsFrance » News"
  feed.updated @news.first.created_at

  @news.each do |item|
    feed.entry(item) do |entry|
      entry.url news_url(item)
      entry.title item.title
      
      entry.content markdown(item.description), :type => 'html'

      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
          author.name item.user_username
        end
    end
  end
end
