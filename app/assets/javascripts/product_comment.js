$(function(){
  function buildHTML(comment){ console.log( comment.content)
    var html = `<div class = "comment__list__box" data-comment-id="${ comment.id }">
                  <div class = "comment__list__box--user"></div>

                  <div class = "comment__list__box--content">
                    ${ comment.content }
                    <div class="comment__list__box--content--icons">
                      <time class="comment__list__box--content--icons--time">
                        ${ comment.date }
                      </time>
                      <div class="comment__list__box--content--icons--delete" data-comment-id="${ comment.id }">
                        <i class="fas fa-trash-alt"></i>
                      </div>
                    </div>
                  </div>
                </div>`
    return html;
  }

  $('#new-comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comment__list').append(html)
      $('#new-comment')[0].reset();
    })
    .fail(function(){
      alert('error');
    })
    .always(function(data){
      $('.button').prop('disabled', false);
    })
  })
})

$(function(){
  $(document).on("click", ".comment__list__box--content--icons--delete",function(){
    $(this).parent().parent().siblings().remove(); // ①クリックした削除ボタンが含まれる".comment__list__box--user"を削除
    $(this).parentsUntil('.comment__list__box').remove(); //⓶クリックした削除ボタンが含まれる".comment__list__box"を削除

  });
})