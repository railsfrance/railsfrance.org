$(document).bind 'pageChanged', ->
  $('#Questionstags').isotope({
    sortBy : 'count'
    sortAscending : false
    getSortData :
      name : ($elem) -> $elem.find('.name').text()
      count : ($elem) -> parseInt($elem.find('.count').text(), 10)
  })

  prevSort = 'count'
  ascending = count: false, name: false
  $('#tagCount').toggleClass 'desc'

  $('#tagName, #tagCount').click ->
    sortName = $(this).attr('href').slice(1)
    if sortName != prevSort
      ascending[sortName] = false
    else
      ascending[sortName] = !ascending[sortName]
    prevSort = sortName

    direction = if ascending[sortName] then 'asc' else 'desc'
    $('#tagName, #tagCount').toggleClass 'asc', false
    $('#tagName, #tagCount').toggleClass 'desc', false
    $(this).toggleClass direction

    $('#Questionstags').isotope({sortBy : sortName, sortAscending : ascending[sortName]})
    return false