if ($('#map_canvas').length)
  map = null
  markers = {}
  resources = ['jobs','users', 'events']

  load_script = ->
    script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "https://maps-api-ssl.google.com/maps/api/js?v=3&sensor=false&callback=initialize&language=fr"
    document.body.appendChild(script);

  clear_markers_for = (resource) ->
    $.each markers[resource], (i, self) ->
      self.setMap(null)

  display_markers_for = (resource) ->
    $.each markers[resource], (i, self) ->
      self.setMap(map)

  set_map_markers = (collection,resource) ->
    $.each collection, (i, self) ->
      info_content = '<div id="window-'+i+'"><h1>'+self.title+'</h1><a href="'+self.link+'" data-skip-pjax=true>Lien direct</a></div>'
      latlng = new google.maps.LatLng(parseFloat(self.latitude).toFixed(6), parseFloat(self.longitude).toFixed(6))
      info_window = new google.maps.InfoWindow({content: info_content})
      marker = new google.maps.Marker({position: latlng, title: self.title, icon: self.icon})

      google.maps.event.addListener marker, 'click', ->
        info_window.open(map,marker)
      markers[resource].push marker
      marker.setMap(map)

  load_resource = (resource) ->
    markers[resource] = []
    $.getJSON '/map/'+resource,(data) ->
      set_map_markers(data, resource)

  # Callback method executed when map scripts are loaded
  window.initialize = ->
    directionsDisplay = new google.maps.DirectionsRenderer()
    zoom = 6
    zoom = 5 if $('#map_canvas').hasClass('home')
    map = new google.maps.Map(document.getElementById("map_canvas"), {
      zoom: zoom,
      center: (new google.maps.LatLng(46.9,1.56)),
      disableDefaultUI: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    })

    load_resource resource for resource in resources

  $ ->
    load_script()

    $('#map_filters').live 'change', ->
      to_display = []
      $("#map_filters :checked").each (i,self) ->
        to_display.push $(self).attr('name')
      $.each resources, (i, resource) ->
        if $.inArray(resource, to_display) >= 0
          display_markers_for resource
        else
          clear_markers_for resource
      return false
  
  #checkbox skin
  $('#filter_jobs,#filter_users,#filter_events').checkbox()
