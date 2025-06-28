<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>에디터 테스트 페이지</title>
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
  <style>
    #editor { margin-bottom: 20px; }
    input[type="text"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
  <h1>PlanEditor</h1>

  <!-- 제목 입력란 -->
  <input type="text" id="titleInput" placeholder="제목을 입력하세요" />

  <!-- Toast UI Editor 영역 -->
  <div id="editor"></div>

  <!-- 제출 버튼 -->
  <button id="submitBtn">제출</button>

  <!-- 결과 메시지 -->
  <div id="resultMessage"></div>

  <!-- Toast UI Editor 스크립트 -->
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  
  <script>
  
    // 에디터 인스턴스 생성
    const Editor = toastui.Editor;
    const editor = new Editor({
      el: document.querySelector('#editor'),
      height: '600px',
      initialEditType: 'wysiwyg',
      previewStyle: 'vertical'
    });

    // 제출 버튼 클릭 이벤트
    document.getElementById('submitBtn').addEventListener('click', function () {
      const planTitle = document.getElementById('titleInput').value.trim();
      const planContent = editor.getHTML();

      if (!planTitle) {
        alert('제목을 입력하세요!');
        return;
      }   
     
     if (planContent == "<p><br></p>") {
        alert('본문을 입력하세요!');
        return;
      }   
     
     console.log("제목", planTitle);
     console.log("본문", planContent);

      // 서버로 전송 (예: /submit 엔드포인트)
      fetch('/editor/submit', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ planTitle: planTitle, planContent: planContent })
      })
      .then(res => res.json())             // JSON 파싱
      .then(data => {
        if (data.code === 200) {
          // 성공
          document.getElementById('resultMessage').textContent = '제출 완료!';
          console.log('서버 응답:', data);
        } else {
          // 서버에서 code≠200 으로 내려온 경우
          throw new Error(data.message || '서버 에러');
        }
      })
      .catch(err => {
        // 네트워크 에러, JSON 파싱 에러, 또는 위에서 던진 Error
        document.getElementById('resultMessage').textContent =
          `제출 실패: ${err.message}`;
        console.error(err);
      });
    });
  </script>
</body>
</html>
