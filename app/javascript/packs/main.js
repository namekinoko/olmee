document.addEventListener('turbolinks:load', () => {
  // サイトを開いた時キャッチフレーズを出現させる関数
  function LoadAnimation(){
    $('#catchphrase').each(function(){
    $(this).addClass('appeartext');
    let animeText = $(this).text();
    let animeTextBox = ""
    animeText.split('').forEach( function( a,t ){
    if( t < 10 ){
      animeTextBox += '<span style="animation-delay:.' + t + 's;">' + a + '</span>'
    }
    else{
      animeTextBox += '<span style="animation-delay:1.' + t + 's;">' + a + '</span>'
    }
    });
    $(this).html( animeTextBox );
    })
  ;}
  // 〜ここまでサイトを開いた時キャッチフレーズを出現させる関数〜

// ハンバーガーメニュー
$( function() {
  $('.btn-gnav').on( "click", function(){
    $(this).toggleClass('open');
    $( '#gnav' ).toggleClass('open');
  });
});
// メニューをクリックされたら、非表示に
$( function() {
  $('.btn-gnav .gnav-menu li a').on( "click", function(){
     $('#gnav').removeClass('open');
  });
});
// 〜〜ここまでハンバーガーメニュー〜〜
  $(window).on( 'load', function () {
    LoadAnimation();
    $(this).removeClass('appeartext');
  });
});
