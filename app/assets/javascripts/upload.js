$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src">
                    <div class="js-remove hidden">削除</div>
                  </div>`;
    return html;
  }

  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
  const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">
                `;
  return html;
  }

  // file_fieldをクリックしたとき
  // $("#test").on("click", function () {
  //   const file_field = $(".js-file:last"); // 一番最後のfile_field（新規でアップロードする箇所）を取得
  //   console.log(file_field)
  //   file_field.trigger("click"); // file_fieldをクリックさせる。
  // });

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5];

   // 既に使われているindexを除外
   lastIndex = $('.js-file_group:last').data('index');
   fileIndex.splice(0, lastIndex);

   $('.hidden-destroy').hide();


  $('#image-file-fields').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      // debugger
      $(`#label_${targetIndex}`).attr("for", `item_images_attributes_${targetIndex + 1}_src`)
      $(`#label_${targetIndex}`).attr("id", `label_${targetIndex + 1}`)
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $(`#image-file-fields`).append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
      
    }
  });


  $('.Sell-contents__imageBox').on('click', function(e) {
    e.stopPropagation();
    const file_field = $('input[type="file"]:last');
    console.log(file_field);
    file_field.trigger('click');
    // $('.js-file_group:last').removeClass("js-remove")
  });

  $(document).on('change', '.js-file', function(e) {
    console.log($(this).next())
    $(this).next().toggleClass('hidden')
  });

  $('#image-file-fields').on('click', '.js-remove', function() {
  // $('#previews').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]),console.log("aaa"));
  });               
});
