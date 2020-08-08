$(document).on('turbolinks:load', function() {              //初回読み込み、リロード、ページ切り替えで動く
  //子カテゴリのhtml作成用の関数
  function buildChildHTML(child){
    let html = `<li class="ChildCategory">
                  <a href="#" id="${child.id}">${child.name}</a>
                </li>`
    return html;
  }
  //孫カテゴリのhtml作成用の関数
  function buildGrandchildHTML(child){
    let html = `<li class="GrandchildCategory">
                  <a href="#" id="${child.id}">${child.name}</a>
                </li>`
    return html;
  }
// 親カテゴリのリストをマウスのオンオフで表示非表示にする
  $(".btn__category").hover(
    //マウスオンされた時の処理
    function(){
      $(".CategoryList:not(:animated)", this).slideDown(100);
    },
    //マウスオフされた時の処理
    function(){
      $(".GrandchildCategory").remove();                  //出ている孫カテゴリのリストを消します
      $(".ChildCategory").remove();                       //出ている子カテゴリのリストを消します
      $(".CategoryList").slideUp(100);
    }
  );
  //親カテゴリのリストにマウスオンされた時、子カテゴリのリストを生成する処理
  $("li.ParentCategory a").on("mouseover",
    function(){
      let id = $(this).attr('id')                         //マウスオンされた親カテゴリのidを取得
      $(".ChildCategory").remove();                       //出ている子カテゴリのリストを消します
      $(".GrandchildCategory").remove();                  //出ている孫カテゴリのリストを消します
      $.ajax({
        type: 'GET',
        url: '/categories/new',
        data: {id: id},
        dataType: 'json',
      })
      .done(function (children){
        children.forEach(function(child){
          let html = buildChildHTML(child);                  //取得した子カテゴリでhtmlを作成
          $("ul.CategoryList__children").append(html);       //作成したhtmlを子カテゴリリストに足していく
        })
      })
    }
  );
  //子カテゴリのリストにマウスオンされた時、孫カテゴリのリストを生成する処理
  $(document).on("mouseover", "li.ChildCategory a",           //動的に生成された要素なので、第二引数で要素を指定する。
    function(){
      let id = $(this).attr('id')                             //マウスオンされた子カテゴリのidを取得
      $(".GrandchildCategory").remove();                      //出ている孫カテゴリのリストを消します
      $.ajax({
        type: 'GET',
        url: '/categories/new',
        data: {id: id},
        dataType: 'json',
      })
      .done(function (children){
        children.forEach(function(child){
          let html = buildGrandchildHTML(child);                //取得した子カテゴリでhtmlを作成
          $("ul.CategoryList__grandchildren").append(html);     //作成したhtmlを子カテゴリリストに足していく
        })
      })
    }
  );
});