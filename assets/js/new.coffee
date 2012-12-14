#= require lib/underscore lib/jquery.validate
preview_area = $('.preview-area')

$('.file-input').bind 'change', (evt)->
  preview_area.html('')
  names = []

  _.each evt.target.files, (file)->

    reader = new FileReader()
    $(reader).bind 'load', (evt)->
      preview_area.append $('<img>').attr
          src: evt.target.result
          style: 'width: 100px;'

    names.push(file.name)
    reader.readAsDataURL(file)

  $('.dummy-file-input').val names.join(',')

$('form.upload-form').validate
  rules:
    description: 'required'

  errorClass: "alert alert-error"
