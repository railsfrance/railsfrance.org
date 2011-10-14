atom_feed :language => 'fr' do |feed|
  feed.title "RailsFrance » Questions"
  feed.updated @questions.first.created_at

  @questions.each do |item|
    feed.entry(item) do |entry|
      entry.url question_url(item)
      entry.title item.title
      entry.content markdown(item.description), :type => 'html'

      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
          author.name item.user_username
        end
    end
  end
end
