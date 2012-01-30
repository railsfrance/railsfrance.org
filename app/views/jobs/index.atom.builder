atom_feed :language => 'fr' do |feed|
  feed.title "RailsFrance > Jobs"
  if @jobs.any?
    feed.updated @jobs.first.created_at

    @jobs.each do |item|
      feed.entry(item) do |entry|
        entry.url job_url(item)
        entry.title item.title
        entry.content :type => 'xhtml' do |html|
          html.p "Entreprise -- #{item.company}"
          html.p "Ville -- #{item.city}"
          html.p item.description
        end

        entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

        entry.author do |author|
          author.name item.company
        end
      end
    end
  end
end
