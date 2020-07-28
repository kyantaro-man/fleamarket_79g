$(function(){
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
   //fileが選択された時に発火するイベント
   $('#image-label').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var files = $('input[type="file"]').prop('files')[0];

    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();
      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files

      //Fileオブジェクトを読み込む
      fileReader.readAsDataURL(file);

      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html =  `<li class="item-image-container__unit--preview" >
                      <div class="item-image-container__unit--caption">
                        <img src="${src}" width="300px" height="300px">
                      </div>
                      <div class="image-option">
                        <div  class="image-option__list">
                          <div class="image-option__list--tag">編集</div>
                        </div>
                        <div class="image-option__list">
                          <a class="image-option__list--tag">削除</a>
                        </div>
                      </div>
                    </li>`
        //ulタグの下にhtmlをappendしています。
        $(html).appendTo(".item-image-container__unit ul").trigger("build");

      };
      //DataTransfer構造のデバッグ
      console.log(dataBox);
      if(dataBox.items.length > 4){
        return false;
     }
    });

  });
  
});
