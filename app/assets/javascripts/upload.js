$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_item_images_attributes_${index}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
  const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
  return html;
  }


  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

   // 既に使われているindexを除外
   lastIndex = $('.js-file_group:last').data('index');
   fileIndex.splice(0, lastIndex);

   $('.hidden-destroy').hide();


  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    $(this).parent().remove();
    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });               
});

      //読み込みが完了すると、srcにfileのURLを格納
      // fileReader.onloadend = function() {
      //   var src = fileReader.result
      //   var html =  `<li class="item-image-container__unit--preview" >
      //                 <div class="item-image-container__unit--caption">
      //                   <img src="${src}" width="300px" height="300px">
      //                 </div>
      //                 <div class="image-option">
      //                   <div  class="image-option__list">
      //                     <div class="image-option__list--tag">編集</div>
      //                   </div>
      //                   <div class="image-option__list">
      //                     <a class="image-option__list--tag">削除</a>
      //                   </div>
      //                 </div>
      //               </li>`
      //   //ulタグの下にhtmlをappendしています。
      //   $(html).appendTo(".item-image-container__unit ul").trigger("build");

      // };
      //DataTransfer構造のデバッグ
    //   console.log(dataBox);
    //   if(dataBox.items.length > 4){
    //     return false;
    //  }