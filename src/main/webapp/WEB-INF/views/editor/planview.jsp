<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>후기 상세글</title>

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

  <!-- Bootstrap & 공통 head -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body class="bg-light">
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- 메뉴(햄버거) 버튼 -->
<button type="button"
        class="fab-circle"
        onclick="location.href='/editor/planlist'"
        aria-label="메뉴">
  <i class="fa-solid fa-bars fa-lg"></i>
</button>

  <div class="container py-5">

    <div class="card shadow-sm">
      <div class="card-body">

        <!-- ▣ 제목 + 수정·삭제 버튼 (우측 정렬) -->
        <div class="d-flex align-items-start">
          <h1 class="card-title mb-3 flex-grow-1">
            ${editor.planTitle}
          </h1>

          <!-- 버튼 그룹 -->
          <div class="btn-group">

            <!-- 수정 버튼 -->
            <form action="${pageContext.request.contextPath}/editor/planupdate"
                  method="get" class="m-0">
              <input type="hidden" name="planId"      value="${editor.planId}"/>
              <input type="hidden" name="curPage"     value="${curPage}"/>
              <input type="hidden" name="listType"    value="${listType}"/>
              <input type="hidden" name="searchType"  value="${searchType}"/>
              <input type="hidden" name="searchValue" value="${searchValue}"/>

              <button type="submit" class="btn btn-outline-dark btn-sm ms-2">
                수정
              </button>
            </form>

<!-- 삭제 버튼 폼 (AJAX로 호출) -->
<form id="deleteForm"
      action="${pageContext.request.contextPath}/editor/plandelete"
      method="post"
      class="d-inline m-0"
      onsubmit="return false;"><!-- 기본 submit 막기 -->

  <input type="hidden" name="planId"      value="${editor.planId}">
  <input type="hidden" name="curPage"     value="${curPage}">
  <input type="hidden" name="listType"    value="${listType}">
  <input type="hidden" name="searchType"  value="${searchType}">
  <input type="hidden" name="searchValue" value="${searchValue}">

  <button type="button" id="deleteBtn"
          class="btn btn-outline-dark btn-sm ms-2">
    삭제
  </button>
</form>


<script>
document.getElementById('deleteBtn').addEventListener('click', async () => {
  if (!confirm('정말 삭제하시겠습니까?')) return;

  const form   = document.getElementById('deleteForm');
  const params = new URLSearchParams(new FormData(form));   // planId 포함

  try {
    const res  = await fetch(form.action, {
      method : 'POST',
      headers: { 'Content-Type':'application/x-www-form-urlencoded' },
      body   : params
    });

    const body = await res.json();        // { code:0, message:"success" … }

    if (body.code === 0) {
      alert('삭제되었습니다.');
      location.href = '${pageContext.request.contextPath}/editor/planlist';
    } else {
      alert('삭제 실패: ' + body.message);
    }
  } catch (err) {
    alert('오류: ' + err.message);
  }
});
</script>
            

          </div><!-- /btn-group -->
        </div><!-- /제목+버튼 -->

        <!-- 메타 정보 -->
        <p class="text-muted mb-4">
          작성자: ${editor.userId}
          | 날짜: ${editor.planRegdate}
          | 추천: ${editor.planRecommend}
          | 조회: ${editor.planCount}
        </p>

        <hr/>

        <!-- 본문 -->
        <div class="card-text" style="white-space:pre-wrap;">
          ${editor.planContent}
        </div>
        
        <hr class="my-4"/>

		<!-- 댓글 입력 폼 (textarea 옆에 버튼) -->
		<form id="commentForm"
		      class="d-flex align-items-center gap-2 mb-3"><!-- ★ 세로 중앙 정렬 -->
		
		  <input type="hidden" name="planId" value="${editor.planId}"/>
		
		  <!-- textarea -->
		  <textarea name="planCommentContent"
		            class="flex-grow-1 form-control"
		            rows="3"
		            style="resize:none;"
		            placeholder="댓글을 입력하세요"></textarea>
		
		  <!-- 버튼 (height 100% 삭제) -->
		<button type="button" id="commentBtn"
		        class="btn btn-dark btn-sm"
		        style="width:80px; height:60px; border-radius:15px;">
		  등록
		</button>
		</form>
		
<br />
		
		<!-- ★↓↓↓ (추가) 댓글 목록 루프 --------------------------------------- -->
		<c:forEach var="c" items="${list}">
		  <div class="border rounded p-3 mb-2">
		    <p class="mb-1 mb-2">${c.planCommentContent}</p>
		    <small class="text-muted">
		      작성자: ${c.userId}
		      |
		      날짜:
		      ${c.planCommentDate}
		    </small>
		  </div>
		</c:forEach>
		
		<!-- ★↓↓↓ (추가) 댓글이 없을 때 --------------------------------------- -->
		<c:if test="${empty list}">
		  <div class="text-muted">등록된 댓글이 없습니다.</div>
		</c:if>
		<!-- ★↑↑↑ (추가 끝) --------------------------------------------------- -->
		
		<!-- ★추가: 댓글 등록 AJAX -->
<script>
/* 댓글 작성 AJAX */
document.getElementById('commentBtn').addEventListener('click', async () => {
  const form  = document.getElementById('commentForm');

  // ★ 필드 이름에 맞춰 읽어오기
  const text  = form.planCommentContent.value.trim();
  if(!text){
    alert('댓글 내용을 입력하세요');
    return;
  }

  // ★ form 에 들어 있는 planId + planCommentContent 를 그대로 직렬화
  const data = new URLSearchParams(new FormData(form));

  try{
    const res  = await fetch('${pageContext.request.contextPath}/editor/commentInsert', {
      method : 'POST',
      headers: { 'Content-Type':'application/x-www-form-urlencoded' },
      body   : data
    });
    const body = await res.json();   // { code:0, message:"success" }

    if(body.code === 0){
      alert('댓글이 등록되었습니다!');
      location.reload();
    }else{
      alert('등록 실패: ' + body.message);
    }
  }catch(err){
    alert('오류: ' + err.message);
  }
});

</script>

      </div><!-- /card-body -->
    </div><!-- /card -->

  </div><!-- /container -->

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
