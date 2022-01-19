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
        $('.input-message').val('');
        $('.submit-message').prop('disabled', false);
        $('#messages').append(`<p class="user-name">自分</p><p class="message">${data.message}</p>`);
      })
      .fail(function(){
        $('.input-message').val('');
        $('.submit-message').prop('disabled', false);
        $('#messages').append(`<p class="message">メッセージの送信に失敗しました</p>`).addClass('right-side');
      })
    });
  });
});