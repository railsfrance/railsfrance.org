module HomeHelper
  MARKERS = %w[jobs users events]

  def map_markers(presenter)
    MARKERS.inject([]) do |container, object|
      presenter.send(object).each do |o|
        container << {title: (o.respond_to?('title') ? o.title : o.username), lat: o.latitude, lng: o.longitude, icon: "#{image_path('map/' + o.class.to_s.downcase + 's.png')}", link: url_for(o)}
      end
      container
    end.to_json
  end
end

