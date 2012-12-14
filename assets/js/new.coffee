#= require lib/underscore lib/jquery.validate lib/additional-methods
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

jQuery.validator.addMethod("filesize", (value, element, params)->
    flag = true 
    self = this
    _.each element.files, (file)->
      if file.size > 100000000
        flag = false 
        return false

    return flag 

, "サイズが大きすぎます" 
)

$('form.upload-form').validate
  rules:
    test: 
      required: true
      filesize: true 
      accept: "gif"

    description:
      required: true

  messages:
    test:
      required: "必須項目です"

  errorClass: "alert alert-error"



