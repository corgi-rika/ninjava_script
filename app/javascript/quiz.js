document.addEventListener('turbo:load', function() {
  const quizButtons = document.querySelectorAll('.quiz-button');
  
  quizButtons.forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault(); // デフォルトのリンク動作を防ぐ
      const userAnswer = button.dataset.answer;
      const correctAnswer = button.dataset.correct;

      if (userAnswer === correctAnswer) {
        alert('すばらしい！正解です！');
      } else {
        alert('ざんねん！不正解です。');
      }

      // 1秒の遅延後に指定されたURLに遷移
      setTimeout(() => {
        window.location.href = button.href; // 正しいリンクを取得していることを確認
      }, 1000);
    });
  });
});
