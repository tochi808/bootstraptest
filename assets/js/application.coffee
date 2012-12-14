
$('.file-input').bind 'change', (evt)->
  $('.preview-area').html('')

  names = []

  _.each evt.target.files, (file)->

    reader = new FileReader()
    $(reader).bind 'load', (evt)->
      $('.preview-area').append $('<img>').attr
          src: evt.target.result
          style: 'width: 100px;'

    names.push(file.name)
    reader.readAsDataURL(file)

  $('.dummy-file-input').val names.join(',')

