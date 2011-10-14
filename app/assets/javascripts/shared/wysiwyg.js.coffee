$(document).bind 'pageChanged', ->
  $('.wysiwyg').tabs({ select: (event, ui) ->
    self = this
    if ui.tab.className == 'wysiwyg_preview_tab'
      $.post '/preview', {content: $('.wysiwyg_write textarea', self).val()}, (data) ->
        $('.wysiwyg_preview', self).html(data)
      , 'html'
  });
