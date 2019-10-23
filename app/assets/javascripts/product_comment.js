$(function(){
  function buildHTML(comment){
    var html = `<div class = "comment__list__box" data-comment-id="${ comment.id }">
                  <div class = "comment__list__box--user">
                    <img class="user-icon" src= "common/user-icon.svg">
                  </div>
                  <div class = "comment__list__box--content>
                    ${ comment.content }
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
      $('.input').val('')
    })
    .fail(function(){
      alert('error');
    })
  })
})