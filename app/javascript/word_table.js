// Turboフレームワークを使って、ページがロードされるたびにイベントリスナーを設定する
document.addEventListener("turbo:load", function () {

  // 行（trタグ）にdata-url属性がついているものをすべて選択する
  const tableRows = document.querySelectorAll("tr[data-url]");

  // 取得したすべての行に対して、クリックイベントリスナーを設定する
  tableRows.forEach(tableRow => {

    // 行がクリックされたときに実行される処理を定義する
    tableRow.addEventListener("click", () => {

      // クリックされた行のdata-url属性の値に基づいて、そのURLに遷移する
      window.location = tableRow.dataset.url;
    });
  });
});
