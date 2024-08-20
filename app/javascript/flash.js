document.addEventListener('turbo:load', () => {
  console.log("Flash message script loaded.");  // 確認用ログ
  const flashMessage = document.querySelector('.flash-notice');

  if (flashMessage) {
    console.log("Flash message found.");  // 確認用ログ
    setTimeout(() => {
      console.log("Starting to fade out flash message.");  // 確認用ログ
      flashMessage.style.transition = 'opacity 0.5s ease-out';
      flashMessage.style.opacity = '0';

      setTimeout(() => {
        console.log("Flash message removed.");  // 確認用ログ
        flashMessage.remove();
      }, 500);  // フェードアウト後、500msで削除
    }, 1000);  // 1000ms (1秒) 後にフェードアウト開始
  } else {
    console.log("No flash message found.");  // フラッシュメッセージが見つからない場合
  }
});
