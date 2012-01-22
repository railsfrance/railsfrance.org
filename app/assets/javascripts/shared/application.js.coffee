$ ->
  hostname = window.location.hostname
  $('a').each (i, e) ->
    if e.hostname != hostname
      $(e).attr({'target': '_blank', 'data-skip-pjax': 'true'})
