atom_feed :language => 'fr' do |feed|
  feed.title "#{@question.title} - RailsFrance"
  last_answer = @answers.last
  feed.updated(last_answer.created_at) if last_answer

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
