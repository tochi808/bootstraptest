#= require lib/underscore lib/jquery.validate lib/additional-methods

$(".file-input").bind("change",(evt)->
  $(".preview-area").html("");

  $.each(evt.target.files,
    (idx, file)->
      if(file.type.substring(0,5) != "image")
        return false

      reader= new FileReader()

      #コールバックとしてreadAsDataURLが完了した後に呼ばれる。
      $(reader).bind("load",(evt)->
        $(".preview-area").append($("<img>").attr(
          src: evt.target.result
          width: "100px"
          height:"100px"
        ))

      )
      #終わるのと同時にonloadというイベントが発生する。
      reader.readAsDataURL(file)
  )
)

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
      fileSize: 5000 

  messages:
    description:
      required: "必須項目です。"
      minlength: "3文字以上、入力してください。"

    "up-file":
      accept: "拡張子はgif,jpgまたはpngを指定してくだい。"
      fileSize: "5000byteよりも大きいサイズのファイルはアップロードできません。"

  errorClass: "alert alert-error"
)