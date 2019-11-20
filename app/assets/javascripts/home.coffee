# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # CPF Mask (tentative)
  $('#cpf').mask('000.000.000-00')

  $('#plate').mask('SSS 0A00')

  # DatePicker
  $("#my-datepicker").datepicker({
    language: "pt-BR",
    startDate: "+0d",
    endDate: "+1y"
    todayBtn: "linked"
    })

  $("#my-datepicker").on('changeDate', ->
    $("#my-input").val(
      $("#my-datepicker").datepicker('getFormattedDate')
    )
  )

  # TimePicker
  $("#my-timepicker").timepicker({
    show2400: true,
    timeFormat: "H:i",
    forceRoundTime: true
  })
