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



$.validator.addMethod(
  "fileSize",
  (value, element ,maximum)->
    console.log(element.files[0].size)
    return element.files[0].size < maximum
  ,"ファイルサイズ大きすぎます。"
)

$(".upload-form").validate(
  rules:
    description:
      required: true
      minlength: 3
    
    email:
      email: true

    "up-file":
      required: true
      accept: "gif|jpg|png"
      fileSize: 50000 

  messages:
    description:
      required: "必須項目です。"
      minlength: "3文字以上、入力してください。"

    "up-file":
      accept: "拡張子はgif,jpgまたはpngを指定してくだい。"
      fileSize: "5000byteよりも大きいサイズのファイルはアップロードできません。"



  errorClass: "alert alert-error"
)
