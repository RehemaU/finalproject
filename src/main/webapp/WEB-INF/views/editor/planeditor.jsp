<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
<%@ include file="/WEB-INF/views/include/editorhead.jsp" %>
<!-- Font Awesome 6 CDN (head에 한 번만) -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<!-- 공통 원형 버튼 스타일 -->
<style>
  .fab-circle{
    position:fixed; bottom:24px; left:24px;
    width:60px; height:60px; border-radius:50%;
    background:#000; color:#fff;
    display:flex; justify-content:center; align-items:center;
    border:none; cursor:pointer; z-index:999;
    transition:transform .2s, box-shadow .2s;
  }
  .fab-circle:hover{transform:translateY(-4px); box-shadow:0 6px 16px rgba(0,0,0,.35);}
  .fab-circle:active{transform:scale(.92);}
</style>

<!-- 로그인 체크 후 되돌아가기 -->
<%
    String userId = (String) request.getSession().getAttribute("userId");
    if (userId == null || userId.isEmpty()) {
%>
    <script>
      alert("로그인이 필요합니다.");
      history.back();
    </script>
<%
      return;  // 이후 JSP 렌더링 중단
    }
%>

</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>

<!-- 메뉴(햄버거) 버튼 -->
<button type="button"
        class="fab-circle"
        onclick="location.href='/editor/planlist'"
        aria-label="메뉴">
  <i class="fa-solid fa-bars fa-lg"></i>
</button>

  <h1>일정 후기 작성</h1>
  <br /><br />

  <!-- ⭐️ 래퍼 시작 -->
  <div class="review-container">
    <input type="text" id="titleInput" placeholder="제목을 입력하세요" />

    <div id="editor"></div>

    <button id="submitBtn">제출</button>

    <div id="resultMessage"></div>
  </div>
  <!-- ⭐️ 래퍼 끝 -->
  
  <!-- Toast UI Editor JS -->
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  <script>
    const BASE_API_URL = '';

    const Editor = toastui.Editor;
    const editor = new Editor({
      el: document.querySelector('#editor'),
      height: '800px',
      initialEditType: 'wysiwyg',
      previewStyle: 'vertical',
      hooks: {
        addImageBlobHook: async (blob, callback) => {
          const formData = new FormData();
          formData.append('image', blob);
          try {
            const res     = await fetch(`${BASE_API_URL}/editor/fileupload`, { method:'POST', body:formData });
            const result  = await res.json();
            const url     = result.url;
            const fname   = result.filename || '업로드된 이미지';
            callback(url, fname);

            /* data-filename 부착 */
            setTimeout(() => {
              document.querySelectorAll('#editor img').forEach(img => {
                if (img.src.includes(url)) img.setAttribute('data-filename', fname);
              });
            }, 0);
          } catch(e) {
            alert('이미지 업로드 실패'); console.error(e);
          }
        }
      }
    });

    document.getElementById('submitBtn').addEventListener('click', async () => {
      const planTitle   = document.getElementById('titleInput').value.trim();
      const planContent = editor.getHTML();

      if (!planTitle)          { alert('제목을 입력하세요.'); return; }
      if (planContent === '<p><br></p>') { alert('본문을 입력하세요.'); return; }


      try{
    	    const res   = await fetch(`${BASE_API_URL}/editor/submit`,{
    	      method : 'POST',
    	      headers: {'Content-Type':'application/json'},
    	      body   : JSON.stringify({planTitle,planContent})
    	    });

    	    /* ① HTTP 상태 먼저 체크 (200~299) */
    	    if(!res.ok) throw new Error('HTTP '+res.status);

    	    /* ② JSON 파싱 후 code 값 확인 */
    	    const body = await res.json();   // 예: { code:200, message:"success", data:{...} }

    	    if(body.code === 200){
    	      alert('제출 완료되었습니다.');      // body.message 로 바꿔도 OK
    	      location.href = '/editor/planlist';   // 리다이렉트
    	    }else{
    	      alert('제출 실패: ' + body.message);
    	    }

    	  }catch(err){
    	    alert('오류: ' + err.message);
    	  }
    });
  </script>

</body>
</html>
