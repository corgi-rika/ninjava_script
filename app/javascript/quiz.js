// /Users/admin/projects/ninjava_script/app/javascript/quiz.js
document.addEventListener('turbo:load', function() {
  const quizButtons = document.querySelectorAll('.quiz-button');
  const quizModal = document.getElementById('quiz-modal');
  const quizModalMessage = document.getElementById('quiz-modal-message');
  
  quizButtons.forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault(); // デフォルトのリンク動作を防ぐ
      const userAnswer = button.dataset.answer;
      const correctAnswer = button.dataset.correct;

      if (userAnswer === correctAnswer) {
        quizModalMessage.textContent = 'すばらしい！正解です！';
      } else {
        quizModalMessage.textContent = 'ざんねん！不正解です。';
      }
      
      // モーダルを表示
      quizModal.style.display = 'block';
      // 1秒の遅延後に指定されたURLに遷移
      setTimeout(() => {
        window.location.href = button.href; // 正しいリンクを取得していることを確認
      }, 1000);
    });
  });
});
