# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#decisions_table').dataTable
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
              "targets": [0],
              "orderable": true
              },{
              "targets": [1],
              "orderable": false
              }]
