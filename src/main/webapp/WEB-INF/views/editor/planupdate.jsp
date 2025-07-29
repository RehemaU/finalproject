<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
<%@ include file="/WEB-INF/views/include/editorhead.jsp" %>
<!-- Font Awesome 6 한 번만 로드 -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<!-- 공통 원형 버튼 스타일 -->
<style>
  .fab-circle{
    position:fixed; bottom:24px; left:24px;      /* ↙ 원하는 위치 */
    width:60px; height:60px; border-radius:50%;
    background:#000; color:#fff;
    display:flex; justify-content:center; align-items:center;
    border:none; cursor:pointer; z-index:999;
    transition:transform .2s, box-shadow .2s;
  }
  .fab-circle:hover{transform:translateY(-4px); box-shadow:0 6px 16px rgba(0,0,0,.35);}
  .fab-circle:active{transform:scale(.92);}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation_editor.jsp" %> <%-- 공통 Header/Nav --%>

<!-- 🔙 뒤로가기 / 게시글 보기 버튼 -->
<button type="button"
        class="fab-circle"
        onclick="history.back()"
        aria-label="뒤로가기">
  <i class="fa-solid fa-chevron-left fa-lg"></i>
</button>

  <h1>후기 수정 페이지</h1>
  <br /><br />
  <div class="review-container">
    <!-- planId, editor 객체는 컨트롤러에서 모델에 담아 전달 -->
    <c:set var="planId" value="${editor.planId}" />

    <!-- 제목 입력 -->
    <input type="text" id="titleInput"
           placeholder="제목을 입력하세요"
           value="<c:out value='${editor.planTitle}'/>" />

    <!-- 본문 에디터 -->
    <div id="editor"></div>

    <button id="submitBtn">제출</button>
    <div id="resultMessage"></div>
  </div>


  <!-- Toast UI Editor JS (editorhead.jsp에 이미 있다면 중복 제거) -->
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

  <script>
    /* 초기 데이터 */
    const planId        = '${planId}';
    const initialTitle  = `<c:out value='${editor.planTitle}'/>`;
    const initialContent= `<c:out value='${editor.planContent}' escapeXml='false'/>`;
	
	if(planId==""||planId==null)
	{
		planId = "${param.planId}";
	}
	
    document.getElementById('titleInput').value = initialTitle;

    /* Editor 초기화 */
    const editor = new toastui.Editor({
      el: document.querySelector('#editor'),
      height:'800px',
      initialEditType:'wysiwyg',
      previewStyle:'vertical',
      initialValue: initialContent,
      hooks:{
        addImageBlobHook: async (blob, cb) => {
          const fd = new FormData(); fd.append('image', blob);
          try{
            const r = await fetch('/editor/fileupload',{method:'POST',body:fd});
            const j = await r.json(); cb(j.url, j.filename);
          }catch(e){ alert('이미지 업로드 실패'); console.error(e); }
        }
      }
    });

    /* 제출 */
    document.getElementById('submitBtn').addEventListener('click', async () =>{
      const planTitle   = document.getElementById('titleInput').value.trim();
      const planContent = editor.getHTML();
  	
      if(!planTitle) return alert('제목을 입력하세요.');
      if(planContent === '<p><br></p>') return alert('본문을 입력하세요.');


      try{
    	    const res   = await fetch(`${BASE_API_URL}/editor/planupdateProc`,{
    	      method : 'POST',
    	      headers: {'Content-Type':'application/json'},
    	      body   : JSON.stringify({planTitle,planContent,planId})
    	    });

    	    /* ① HTTP 상태 먼저 체크 (200~299) */
    	    if(!res.ok) throw new Error('HTTP '+res.status);

    	    /* ② JSON 파싱 후 code 값 확인 */
    	    const body = await res.json();   // 예: { code:200, message:"success", data:{...} }

    	    if(body.code === 200){
    	      alert('제출되었습니다.');      // body.message 로 바꿔도 OK
    	      location.href = '/editor/planview?planId=' + encodeURIComponent(planId);   // 리다이렉트
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
