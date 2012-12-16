#= require lib/underscore lib/jquery.validate lib/additional-methods

$(".file-input").bind("change",(evt)->
  console.log  evt.target.files[0].type

  if(evt.target.files[0].type.substring(0,5) != "image")
    console.log "imgでない"
    return
  
  reader= new FileReader()

  #コールバックとしてreadAsDataURLが完了した後に呼ばれる。
  $(reader).bind("load",(evt)->
    
    $(".preview-area").html($("<img>").attr(src:evt.target.result))

  )

  #終わるのと同時にonloadというイベントが発生する。
  reader.readAsDataURL(evt.target.files[0])
  
  console.log "test"

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