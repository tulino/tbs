$ ->
  $('#users-table').dataTable
    language:
      'sProcessing': 'Yükleniyor...'
      'sLengthMenu': 'Sayfada _MENU_ Kayıt Göster'
      'sZeroRecords': 'Eşleşen Kayıt Bulunmadı'
      'sInfo': '  _TOTAL_ Kayıttan _START_ - _END_ Arası kayıtlar'
      'sInfoEmpty': 'Kayıt Yok'
      'sInfoFiltered': '( _MAX_ Kayıt içerisinden Bulunan)'
      'sInfoPostFix': ''
      'sSearch': 'Bul:'
      'sUrl': ''
      'oPaginate':
        'sFirst': 'İlk'
        'sPrevious': 'Önceki'
        'sNext': 'Sonraki'
        'sLast': 'Son'
    processing: true
    serverSide: true
    searching: true
    deferRender: true
    ajax: $('#users-table').data('source')
    pagingType: 'full_numbers'
    ordering: true
    columns: [
      { data: 'first_name' }
      { data: 'last_name' }
      { data: 'ubs_no', orderable: false }
      { data: 'tc_no', orderable: false }
    ]