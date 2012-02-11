$ ->
  if $('#flash')
    $('.flash-closer').live 'click', ->
      $('#flash').slideUp 500
    $('#flash').slideDown(500)
    window.setTimeout (-> $('#flash').slideUp 500), 7000
