$(document).on('turbolinks:load', function(){
  $('#slide').slick({
    autoplay:true,
    dots:true,
    arrows: true,
    // prevArrow: '<div class="slide-arrow prev-arrow"><img src="top_page/arrow-left.png"></div>'
  });
});