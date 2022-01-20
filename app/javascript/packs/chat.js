// グループチャット新規メッセージ作成時の処理
// ajaxを使うことで非同期処理を実装
document.addEventListener('turbolinks:load', () => {
  $( function() {
    $('#new-message').on( "submit", function(e){
      e.preventDefault();
      let formData = new FormData(this);
      let url = $(this).attr('action'); 
      $.ajax({
        url: url,
        type: "POST",
        data: formData,
        dataType:'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        console.log(data)
        $('.input-message').val('');
        $('.submit-message').prop('disabled', false);
        if( data.new_chat.user_id == data.current_user_id ){
          $('#messages').append(`<div class="right-side"><p class="user-name">自分</p><p class="message">${data.new_chat.message}</p></div>`);
        }else{
          $('#messages').append(`<div class="left-side"><p class="user-name">${data.current_user_nickname}</p><p class="message">${data.new_chat.message}</p></div>`);
        }
      })
      .fail(function(){
        $('.input-message').val('');
        $('.submit-message').prop('disabled', false);
        alert('メッセージの送信に失敗しました')
      })
    });
  });
});