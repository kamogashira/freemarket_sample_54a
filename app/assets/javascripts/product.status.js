$(document).on('turbolinks:load',function(){
  if(document.URL.match('selling')) {
    //出品中タブが選択された場合に実行する内容
    $('.mypage-item__bottom--status').css('background-color','');
    $('.side--list--item:nth-child(6)').css('background-color','#eee');
    $('.side--list--item:nth-child(6) a').css('font-weight','600');
  }
  if(document.URL.match('trading')) {
    //取引中タブが選択された場合に実行する内容
    $('.mypage-item__bottom--status').css('background-color','red');
    $('.side--list--item:nth-child(7)').css('background-color','#eee');
    $('.side--list--item:nth-child(7) a').css('font-weight','600');
  }
  if(document.URL.match('completed')) {
    //売却済みタブが選択された場合に実行する内容
    $('.mypage-item__bottom--status').css('background-color','red');
    $('.side--list--item:nth-child(8)').css('background-color','#eee');
    $('.side--list--item:nth-child(8) a').css('font-weight','600');    
  }
});
