# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# pad = (n) ->
#   if n < 10 then '0' + n else n

dateFormat = (d) ->
  pad = (n) ->
    if n < 10 then '0' + n else n
  pad(d.getDate()) + '.' + pad(d.getMonth() + 1) + '.' + d.getFullYear() + ' - ' + pad(d.getHours()) + ':' + pad(d.getMinutes())

printDiv = (divName) ->
  printContents = document.getElementById(divName).innerHTML
  originalContents = document.body.innerHTML
  document.body.innerHTML = printContents
  window.print()
  document.body.innerHTML = originalContents

$ ->

$ ->
  $('.show-event-responses').click ->
    tr = $(this).closest('tr')
    eventId = tr[0].attributes[0].value
    $('#event-modal-title').text(tr[0].attributes[1].value)
    if eventId != ""
      $('#event-id-modal').val(eventId)
      $('#event-responses-table-body').empty()
      if(!tr[0].attributes[2].value)
        $('#event-responses-table-footer').empty()
      $.ajax
          url: "/events/#{eventId}/event_responses"
          type: 'GET'
          dataType: 'json'
          success: (result) ->
            $.each result, (key, eventReponse) ->
              explanation
              if eventReponse.explanation == null
                explanation = ""
              else
                explanation = eventReponse.explanation

              date = new Date(eventReponse.created_at);
              $('#event-responses-table-body').append "<tr><td>#{eventReponse.event_status.status}</td><td>#{explanation}</td><td>#{dateFormat(date)}</td></tr>"
              $('.event-id-modal').val(eventId)
          error: (error) ->
            console.log error

  $('.form-response-button').click ->
    $(this).prop 'disabled', true
    if $(this).hasClass('admin-confirm')
      $('#event-status-id-modal').val(2)
    else if $(this).hasClass('admin-reject')
      $('#event-status-id-modal').val(3)
    else if $(this).hasClass('advisor-confirm')
      $('#event-status-id-modal').val(5)
    else if $(this).hasClass('advisor-reject')
      $('#event-status-id-modal').val(6)
    else if $(this).hasClass('president-resend')
      $('#event-status-id-modal').val(4)
    else if $(this).hasClass('dean-reject')
      $('#event-status-id-modal').val(9)
    else if $(this).hasClass('dean-confirm')
      $('#event-status-id-modal').val(7)
    $('#event-response-form').submit()


  $('#event_locations_list').append("<option value='Diğer'>Diğer</option>")
  $('#event_locations_list').on 'select2:select', (e) ->
    selectedValue = $(this).val()
    if selectedValue != "Diğer"
      $('#event_location').prop('readonly', true);
      $('#event_location').val(selectedValue)
    else
      $('#event_location').prop('readonly', false);
      $('#event_location').val('')

  $('#print-event').click ->
    console.log(123)
    printDiv("print-place")



  $('.other_events').dataTable
    language: {
          "sProcessing": "Yükleniyor...",
          "sLengthMenu": "Sayfada _MENU_ Kayıt Göster",
          "sZeroRecords": "Eşleşen Kayıt Bulunmadı",
          "sInfo": "  _TOTAL_ Kayıttan _START_ - _END_ Arası kayıtlar",
          "sInfoEmpty": "Kayıt Yok",
          "sInfoFiltered": "( _MAX_ Kayıt içerisinden Bulunan)",
          "sInfoPostFix": "",
          "sSearch": "Bul:",
          "sUrl": "",
          "oPaginate": {
          "sFirst": "İlk",
          "sPrevious": "Önceki",
          "sNext": "Sonraki",
          "sLast": "Son" }},
    "bPaginate": true,
    "pageLength": 10,
    "bProcessing": true,
    "order": [[ 1, 'asc' ]],
    "columnDefs": [{
              "targets": [1,2,3,4,5],
              "orderable": true
              },{
              "targets": [0],
              "orderable": false
              }]

  $('.events').dataTable
      language: {
            "sProcessing": "Yükleniyor...",
            "sLengthMenu": "Sayfada _MENU_ Kayıt Göster",
            "sZeroRecords": "Eşleşen Kayıt Bulunmadı",
            "sInfo": "  _TOTAL_ Kayıttan _START_ - _END_ Arası kayıtlar",
            "sInfoEmpty": "Kayıt Yok",
            "sInfoFiltered": "( _MAX_ Kayıt içerisinden Bulunan)",
            "sInfoPostFix": "",
            "sSearch": "Bul:",
            "sUrl": "",
            "oPaginate": {
            "sFirst": "İlk",
            "sPrevious": "Önceki",
            "sNext": "Sonraki",
            "sLast": "Son" }},
      "bPaginate": true,
      "pageLength": 10,
      "bProcessing": true,
      "order": [[ 1, 'asc' ]],
      "columnDefs": [{
                "targets": [1,2,3,4],
                "orderable": true
                },{
                "targets": [0,5],
                "orderable": false
                }]
