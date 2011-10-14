atom_feed :language => 'fr' do |feed|
  first_answer = @answers.first
  feed.title "#{first_answer.question_title} - RailsFrance"
  feed.updated first_answer.created_at

  @answers.each do |item|
    feed.entry(item, :url => item.question) do |entry|
      entry.url question_url(item.question)
      entry.title "#{item.question_title} - RailsFrance"
      entry.content markdown(item.description), :type => 'html'

      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
          author.name item.user_username
        end
    end
  end
end