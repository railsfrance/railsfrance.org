$(document).bind 'pageChanged', ->
  $('#pagination,span a').click -> $('html, body').scrollTop 400