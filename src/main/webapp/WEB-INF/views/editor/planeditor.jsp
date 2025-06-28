<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>후기작성페이지</title>
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
  <style>
    #editor { margin-bottom: 20px; }
    input[type="text"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      margin-bottom: 15px;
    }
    #resultMessage {
      margin-top: 15px;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <h1>일정 후기 작성</h1>

  <input type="text" id="titleInput" placeholder="제목을 입력하세요" />

  <div id="editor"></div>

  <button id="submitBtn">제출</button>

  <div id="resultMessage"></div>

  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
  const BASE_API_URL = '';

  const Editor = toastui.Editor;
  const editor = new Editor({
    el: document.querySelector('#editor'),
    height: '600px',
    initialEditType: 'wysiwyg',
    previewStyle: 'vertical',
    hooks: {
      addImageBlobHook: async (blob, callback) => {
        const formData = new FormData();
        formData.append('image', blob);

        try {
          const res = await fetch(`${BASE_API_URL}/editor/fileupload`, {
            method: 'POST',
            body: formData
          });

          const result = await res.json();
          const imageUrl = result.url;
          const filename = result.filename || '업로드된 이미지';

          // Toast UI Editor에 이미지 삽입
          callback(imageUrl, filename);

          // 삽입 직후 DOM 접근해서 data-filename 추가
          setTimeout(() => {
            const imgs = document.querySelectorAll('#editor img');
            imgs.forEach(img => {
              if (img.src.includes(imageUrl)) {
                img.setAttribute('data-filename', filename);
              }
            });
          }, 0);
        } catch (err) {
          alert('이미지 업로드 실패');
          console.error('이미지 업로드 오류:', err);
        }
      }
    }
  });

  document.getElementById('submitBtn').addEventListener('click', () => {
    const planTitle = document.getElementById('titleInput').value.trim();
    const planContent = editor.getHTML();

    if (!planTitle) {
      alert('제목을 입력하세요!');
      return;
    }

    if (planContent === "<p><br></p>") {
      alert('본문을 입력하세요!');
      return;
    }

    console.log("제목:", planTitle);
    console.log("본문:", planContent);

    fetch(`${BASE_API_URL}/editor/submit`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ planTitle, planContent })
    })
    .then(res => {
      if (!res.ok) throw new Error('서버 오류');
      return res.text();
    })
    .then(data => {
      document.getElementById('resultMessage').textContent = '✅ 제출 완료!';
      console.log('서버 응답:', data);
    })
    .catch(err => {
      document.getElementById('resultMessage').textContent = '❌ 제출 실패: ';
      console.log('실패 응답:', err.message);
    });
  });
</script>

</body>
</html>
