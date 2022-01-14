document.addEventListener('turbolinks:load', () => {
// ハンバーガーメニュー
$(function() {
  $('.btn-gnav').on("click", function(){
    $(this).toggleClass('open');
    $('#gnav').toggleClass('open');
  });

});

// メニューをクリックされたら、非表示に
$(function() {
  $('.btn-gnav .gnav-menu li a').on("click", function(){
     $('#gnav').removeClass('open');
  });
});
// 〜〜ここまでハンバーガーメニュー〜〜
});