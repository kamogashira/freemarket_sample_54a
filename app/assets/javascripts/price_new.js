$(document).on('turbolinks:load', function(){

  $(".price-form").on("keyup", function() {
    var price = $(this).val();
    if ((price >= 300) && (price <= 9999999)) {
      var fee = Math.floor(price * 0.1);
      var profit = price - fee;
      $(".content-form__status__fee-right").text("¥ " + fee);
      $(".content-form__status__profit-right").text("¥ " + profit);
    } else {
      $('.content-form__status__fee-right').html('-');
      $('.content-form__status__profit-right').html('-');
    }
  });

  $(".price-form").on("keyup", function(){
    var price = $(this).val();
    if ((price >= 300) && (price <= 9999999)) {
      var fee_num = Math.floor(price * 0.1);
      var first_str = String(fee_num); 
      var fee_str = first_str.replace(/(\d)(?=(\d\d\d)+$)/g, '$1,');
      $(".content-form__status__fee-right").text("¥ " + fee_str);
      var profit_num = price - fee_num
      var second_str = String(profit_num);
      var profit_str = second_str.replace(/(\d)(?=(\d\d\d)+$)/g, '$1,');
      $(".content-form__status__profit-right").text("¥ " + profit_str);
    } else {
      $('.content-form__status__fee-right').html('-');
      $('.content-form__status__profit-right').html('-');
    }
  });
});