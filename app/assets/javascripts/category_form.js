$(document).on('turbolinks:load', function() {              //初回読み込み、リロード、ページ切り替えで動く

  function buildChildBoxHTML(child){
    let html = `<option value="${child.id}">${child.name}</option>`
    return html;
  }




  $("#parent").on('change', function(){             //親カテゴリのが選択が変わると、子カテゴリのボックスを生成する
    let id = $(this).val()                          //選択されたカテゴリのidを取得
    $("#grandchild").remove();                      //孫カテゴリのボックスを消す
    $("#child").remove();                           //子カテゴリのボックスを消す
    $.ajax({
      type: 'GET',
      url: '/categories/new',
      data: {id: id},
      dataType: 'json',
    })
    .done(function (children){
      let childHTML = `<select name="child", id="child">
                        <option value>選択してください</option>`
      children.forEach(function(child){
        let html = buildChildBoxHTML(child);
        childHTML += html;
      })
      childHTML += `</select>`
      $(".ItemCategory__child").append(childHTML);
    });
  })
  //子カテゴリは動的に生成されたものなので、第二引数で指定する
  $(document).on('change', '#child', function(){             //子カテゴリのが選択が変わると、子カテゴリのボックスを生成する
    let id = $(this).val()                                   //選択されたカテゴリのidを取得
    $("#grandchild").remove();                               //孫カテゴリのボックスを消す
    $.ajax({
      type: 'GET',
      url: '/categories/new',
      data: {id: id},
      dataType: 'json',
    })
    .done(function (children){
      let childHTML = `<select name="item[category_id]", id="item_category_id">
                        <option value>選択してください</option>`
      children.forEach(function(child){
        let html = buildChildBoxHTML(child);
        childHTML += html;
      })
      childHTML += `</select>`
      $(".ItemCategory__grandchild").append(childHTML);
    });
  })
});