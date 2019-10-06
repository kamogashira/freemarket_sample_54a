// マイページ内の「お知らせ」と「やることリスト」のタブ切り替え
$(document).on('turbolinks:load',function(){
$(function(){
  var ltab = $('.mypage-tabs__left'),
      rtab = $('.mypage-tabs__right')
      // 左のタブをクリックした時の動作
      ltab.click(function(){
        $('.tab-content__right').hide();
        $('.tab-content__left').show();
        $('.mypage-tabs__news').css({
          'background':'white',
          'border-top':'2px solid red'
        });
        $('.mypage-tabs__notice').css({
          'background':'#eee',
          'border-top':'none'
        });
        // 一覧を見るボタンを元に戻す
        $('.mypage-item--all').show();
      });
      // 右のタブをクリックした時の動作
      rtab.click(function(){
        $('.tab-content__right').show();
        $('.tab-content__left').hide();
        $('.mypage-tabs__notice').css({
          'background':'white',
          'border-top':'2px solid red'
        });
        $('.mypage-tabs__news').css({
          'background':'#eee',
          'border-top':'none'
        });
      })
      // 一覧を見るをクリックした時の動作
      $('.mypage-item--all').click(function(){
        $('.mypage-item--all').hide();
      });
});

// マイページ内の「お知らせ」と「やることリスト」のタブ切り替え
$(function(){
  var tltab = $('.mypage-buy--tabs__trading-now'),
      trtab = $('.mypage-buy--tabs__trading-old')
      // 左のタブをクリックした時の動作
      tltab.click(function(){
        $('.mypage-buy--content__old--list').hide();
        $('.mypage-buy--content__now--list').show();
        $('.mypage-buy--tabs__trading-now').css({
          'background':'white',
          'border-top':'2px solid red'
        });
        $('.mypage-buy--tabs__trading-old').css({
          'background':'#eee',
          'border-top':'none'
        });
      });
      // 右のタブをクリックした時の動作
      trtab.click(function(){
        $('.mypage-buy--content__old--list').show();
        $('.mypage-buy--content__now--list').hide();
        $('.mypage-buy--tabs__trading-old').css({
          'background':'white',
          'border-top':'2px solid red'
        });
        $('.mypage-buy--tabs__trading-now').css({
          'background':'#eee',
          'border-top':'none'
        });
      });
    });
});
