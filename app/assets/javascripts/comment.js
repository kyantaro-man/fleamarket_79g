$(document).on('turbolinks:load', function(){
  function buildcommentHTML(comment,id){
    if(comment.user_id == id.id){
      let html = `<div class="CommentContent">
                    <div class="CommentContent__user">
                      ${comment.user_name}
                      <span>出品者</span>
                    </div>
                    <div class="CommentContent__text">
                      ${comment.text}
                    </div>
                  </div>`
      return html;
    }else{
      let html = `<div class="CommentContent">
                    <div class="CommentContent__user">
                      ${comment.user_name}
                    </div>
                    <div class="CommentContent__text">
                      ${comment.text}
                    </div>
                  </div>`
      return html;
    }
  }



  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false

    })
    .done(function(data){
      let id = $(".CommentBox").data()
      let html = buildcommentHTML(data, id);
      $('.CommentField').append(html);
      $('.CommentForm__textarea').val('');
      $('.CommentForm__submit').prop('disabled', false);
      $('.CommentField').animate({ scrollTop: $('.CommentField')[0].scrollHeight});
    })
  })
});