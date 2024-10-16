document.addEventListener('turbo:load', function() {
  const quizButtons = document.querySelectorAll('.quiz-button');
  const quizModal = document.getElementById('quiz-modal');
  const quizModalMessage = document.getElementById('quiz-modal-message');
  const correctIcon = document.getElementById('quiz-modal-icon-correct'); // 正解のアイコン要素を取得
  const incorrectIcon = document.getElementById('quiz-modal-icon-incorrect'); // 不正解のアイコン
  const correctSound = document.getElementById('correct-sound');
  const incorrectSound = document.getElementById('incorrect-sound');
  const lowScoreSound = document.getElementById('low-score-sound'); // 低得点用の音声
  const midScoreSound = document.getElementById('mid-score-sound'); // 中得点用の音声


   // 追加: lowScoreSoundが正しく取得されているか確認
   console.log('lowScoreSound:', lowScoreSound);

  quizButtons.forEach(button => {
    let clicked = false;  // クリックされたかどうかを確認するフラグ

    button.addEventListener('click', function(event) {
      if (!clicked) {  // まだクリックされていない場合のみ処理を行う
        clicked = true;
        event.preventDefault(); // デフォルトのリンク動作を防ぐ
        const userAnswer = button.dataset.answer;
        const correctAnswer = button.dataset.correct;
        const url = button.dataset.url;

        // モーダルのクラスをリセット
        quizModal.classList.remove('correct', 'incorrect');

        // アイコンをリセット
        correctIcon.style.display = 'none'; // 正解アイコンを非表示
        incorrectIcon.style.display = 'none'; // 不正解アイコンを非表示

        if (userAnswer === correctAnswer) {
          quizModalMessage.textContent = 'すばらしい！正解です！';
          quizModal.classList.add('correct');  // 正解のクラスを追加
          correctIcon.style.display = 'block';  // 正解アイコンを表示
          correctSound.play(); // 正解時の音声を再生
        } else {
          quizModalMessage.textContent = 'ざんねん！不正解です。';
          quizModal.classList.add('incorrect');  // 不正解のクラスを追加
          incorrectIcon.style.display = 'block';  // 不正解アイコンを表示
          incorrectSound.play(); // 不正解時の音声を再生
        }

        // モーダルを表示
        quizModal.style.display = 'block';
        // 1秒の遅延後に指定されたURLに遷移
        setTimeout(() => {
          window.location.href = url; // データ属性からURLを取得
        }, 1000);
      }
    });
  });

  // 結果画面で正しい要素が取得できるか確認
  const resultParagraph = document.querySelector('.quiz-result-container p');
  console.log('resultParagraph:', resultParagraph);

  if (resultParagraph) {
    const correctCount = parseInt(resultParagraph.textContent.match(/\d+/)[0], 10);
    console.log('correctCount:', correctCount);  // 正解数を確認
    
    if (correctCount <= 5) {
      lowScoreSound.play();  // 5問以下の時に音声を再生
    } else if (correctCount >= 6 && correctCount <= 8) {
      midScoreSound.play();  // 6問以上8問以下の時に中得点音声を再生
    }
  }
});