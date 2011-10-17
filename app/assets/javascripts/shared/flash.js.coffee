$ ->
  if $('#flash')
    $('#flash').slideDown(500)
    window.setTimeout (-> $('#flash').slideUp 500), 7000
