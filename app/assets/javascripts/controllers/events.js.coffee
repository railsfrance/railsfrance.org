$ ->
   $('#event_date').datetimepicker
    showMinute: true
    dateFormat: 'dd-mm-yy'
    timeFormat: 'hh:mm'
    minDate: (new Date).getDate + 1
    stepMinute: 10
    firstDay: 1
    timeText: 'Heure'
    hourText: 'Heure'
    minuteText: 'Minutes'
    minuteGrid: 10
    closeText: 'Ok'