$(document).on('turbolinks:load', function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='select-wrap' id= 'children_wrapper'>
                        <div class='select-default'>
                          <select class="select-form" id="child_category" name="product[child_id]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          <select>
                          <i class='fas fa-chevron-down'></i>
                        </div>
                      </div>`;
    $('.content-form__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='select-wrap' id= 'grandchildren_wrapper'>
                              <div class='select-default'>
                                <select class="select-form" id="grandchild_category" name="product[category_id]">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                                <i class='fas fa-chevron-down'></i>
                              </div>
                            </div>`;
    $('.content-form__category').append(grandchildSelectHtml);
  }

  // サイズカテゴリーの表示作成
  function appendSizeBox(insertHTML){
    var sizeSelectHtml = '';
    sizeSelectHtml = `<div class='content-form__status' id= 'size_wrapper'>
                        <label>
                          サイズ
                          <span class='form-require'>必須</span>
                        </label>
                        <div class='select-wrap'>
                          <div class='select-default'>
                            <select class="select-form" id="size_category" name="product[size_id]">
                              <option value="---" data-category="---">---</option>
                              ${insertHTML}
                            </select>
                            <i class='fas fa-chevron-down'></i>
                          </div>
                        </div>
                      </div>`;
    $('.content-form__category').append(sizeSelectHtml);
  }

  // ブランドカテゴリーの表示作成
  function appendBrandBox(){
    var brandSelectHtml = '';
    brandSelectHtml = `<div class='content-form__status' id= 'brand_wrapper'>
                        <label>
                          サイズ
                          <span class='form-arbitrary'>必須</span>
                        </label>
                        <div class="select-wrap">
                          <input class="select-default" value="" placeholder="例）シャネル" name="product[brand_id]">
                        </div>`;
    $('.content-form__category').append(brandSelectHtml);
  }

  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
    if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('子カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.content-form__category').on('change', '#child_category', function(){
    var childId = document.getElementById('child_category').value; //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('孫カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
  // 孫カテゴリー選択後のイベント
  $('.content-form__category').on('change', '#grandchild_category', function(){
    var childName = $('#child_category option:selected').text();
    var grandChildId = document.getElementById('grandchild_category').value; //選択された孫カテゴリーのidを取得

    if (grandChildId != "---"){ //孫カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_size',
        type: 'GET',
        data: { child_name: childName },
        dataType: 'json'
      })
      .done(function(sizelist){

        //サイズを持つ子カテゴリー配列
        const itemWidhSize = ['トップス','ジャケット/アウター','パンツ','スカート','ワンピース','ルームウェア/パジャマ','ベビー服(女の子用) ~95cm','ベビー服(男の子用) ~95cm','ベビー服(男女兼用) ~95cm','キッズ服(女の子用) 100cm~','キッズ服(男の子用) 100cm~','キッズ服(男女兼用) 100cm~']
        //選択された子カテゴリーがサイズを持つか判定
        const result = $.inArray(childName, itemWidhSize);

        if (result !== -1){
          $('#size_wrapper').remove();  //孫が変更された時、サイズ以下を削除する
          $('#brand_wrapper').remove();
          var insertHTML = '';
          sizelist.forEach(function(size){
            insertHTML += appendOption(size);
          });
          appendSizeBox(insertHTML);
        }
        appendBrandBox();
      })
      .fail(function(){
        alert('サイズカテゴリー取得に失敗しました');
      })
    }
    else{
      $('#size_wrapper').remove();  //孫カテゴリーが初期値になった時、サイズ以下を削除する
      $('#brand_wrapper').remove();
    }
  });
});