$ ->
  $('form#search').live "change", ->
    $(this).submit()

  $('#search_job_cdi,#search_job_cdd,#search_job_freelance,#search_job_internship').checkbox()



