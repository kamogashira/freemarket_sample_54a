$(document).on('turbolinks:load', function(){
  $('.main-window').slick({
      arrows:false,
      asNavFor:'.sub-window',
  });
  $('.sub-window').slick({
      asNavFor:'.main-window',
      focusOnSelect: true,
      slidesToShow:5,
      slidesToScroll:1,
      arrows:false,
      rows: 1,
      slidesPerRow: 5
  });
});  