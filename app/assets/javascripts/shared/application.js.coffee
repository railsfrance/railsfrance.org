$ ->
  hostname = window.location.hostname
  $('a').each (i, e) ->
    if e.hostname != hostname && !e.href.match("javascript")
      $(e).attr({'target': '_blank', 'data-skip-pjax': 'true'})
