$(document).on('turbolinks:load', function(){
  $('#price_calc').on('keyup', function(){
    var data = $('#price_calc').val();
    if ((data >= 300) && (data <= 9999999))  {
      var profit = Math.round(data * 0.9)
      var fee = (data - profit)
      $('.content-form__status__fee-right').html(fee)
      $('.content-form__status__fee-right').prepend('¥')
      $('.content-form__status__profit-right').html(profit)
      $('.content-form__status__profit-right').prepend('¥')
      $('#price').val(data)
    }
    else {
      $('.content-form__status__fee-right').html('-');
      $('.content-form__status__profit-right').html('-');
    }
  })
})