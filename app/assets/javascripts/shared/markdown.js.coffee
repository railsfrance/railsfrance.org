$(document).bind 'pageChanged', ->
  $('#dialogMarkdownHelp').dialog
    autoOpen: false
    show: "blind"
    hide: "explode"
    modal: true
    minWidth:855
    draggable: true
  $('#markdownHelp').click  (event) ->
    event.preventDefault()
    $( "#dialogMarkdownHelp" ).dialog( "open" );
    return false