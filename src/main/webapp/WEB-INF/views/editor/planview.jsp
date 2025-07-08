<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>후기 상세글</title>

<!-- Kakao Maps -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=services,clusterer,drawing"></script>


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

<!-- 좋아요버튼 -->
<style>
  .btn-like {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    padding: 0.25rem 0.75rem;
    border: 1px solid #ccc;
    border-radius: 0.5rem;
    background-color: #fff;
    font-size: 1rem;
    transition: background-color .2s, border-color .2s;
  }
  .btn-like:hover {
    background-color: #f5f5f5;
  }
  .btn-like .fa-heart {
    font-size: 1.2rem;
  }
  /* 눌린(좋아요) 상태 */
  .btn-like.liked {
    background-color: #ffe6e6;
    border-color: #e57373;
  }
  .btn-like.liked .fa-heart {
    color: #e57373;
  }
</style>
<!-- 스케줄스타일 -->
  <style>
  h2{font-family:'Inter',sans-serif;font-size:28px;font-weight:700;letter-spacing:-.02em}
  
    .schedule-list { width: 340px; max-height: 600px; overflow-y: auto; }
    .day-title { margin-top: 24px; font-size: 22px; font-weight: 600; }
    .mycard {
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 14px;
      margin: 10px 0;
    }
    .mycard strong { font-size: 16px; }
    .mycard time { display: block; margin-top: 4px; color: #666; font-size: 14px; }
    #map { flex: 1 1 0%; min-height: 600px; border: 1px solid #ccc; }
    .container { display: flex; gap: 40px; max-width: 1440px; margin: 48px auto; padding: 0 48px; }
    @media (max-width: 760px) {
      .container { flex-direction: column; }
      .schedule-list { width: 100%; }
      #map { min-height: 480px; }
    }
  .btn-group {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin: 10px 0px;
  }

  .action-btn {
    display: inline-block;
    padding: 12px 20px;
    font-size: 15px;
    font-weight: 600;
    background: #111;
    color: #fff;
    border: none;
    border-radius: 8px;
    text-decoration: none;
    cursor: pointer;
    transition: background 0.2s ease;
  }

  .action-btn:hover {
    background: #333;
  }

  .action-btn.gray {
    background: #bbb;
    color: #fff;
  }

  .action-btn.gray:hover {
    background: #999;
  }

  .btn-group form {
    margin: 0;
  }
  </style>
<!-- 스케줄스타일 -->

  <!-- Bootstrap & 공통 head -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body class="bg-light">
  <%@ include file="/WEB-INF/views/include/navigation_editor.jsp" %>

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
        <div class="d-flex justify-content-between align-items-start mb-3">
        <div>
          <h1 class="card-title mb-2">
            ${editor.planTitle}
          </h1>
        <!-- 메타 정보 -->
        <p class="text-muted mb-4">
          작성자: ${editor.userName}
          | 날짜: ${editor.planRegdate}
          | 추천: ${editor.planRecommend}
          | 조회: ${editor.planCount}
        </p>
        </div>
        <!-- 버튼 그룹 -->
        <div class="btn-group flex-shrink-0 ms-3">

<c:if test="${loginId eq editor.userId}">

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

<!-- 게시판 삭제 ajax -->		
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

</c:if>

        </div><!-- /btn-group -->
        </div><!-- /제목+버튼 -->

        <hr/>
        
        <!-- -------------------------------------------------------------------------------------- -->
        
      <div class="container">
        <section class="schedule-list">
          <c:set var="maxDay" value="0" />
          <c:forEach var="c" items="${calList}">
            <c:if test="${c.calDayNo > maxDay}">
              <c:set var="maxDay" value="${c.calDayNo}" />
            </c:if>
          </c:forEach>
          <c:forEach var="d" begin="1" end="${maxDay}">
            <h3 class="day-title">Day ${d}</h3>
            <c:forEach var="c" items="${calList}">
              <c:if test="${c.calDayNo == d}">
                <div class="mycard">
                  <strong>${c.locationName}</strong>
                  <time>${c.calanderStartTime} ~ ${c.calanderEndTime}</time>
                </div>
              </c:if>
            </c:forEach>
          </c:forEach>
        </section>
        <div id="map"></div>
      </div>
        
        
          <script>
    const calList = [
      <c:forEach var="c" items="${calList}" varStatus="s">
        <c:if test="${not empty c.lat && not empty c.lon}">
          { 
            name: "${c.locationName}", 
            lat: ${c.lat}, 
            lon: ${c.lon}, 
            dayNo: ${c.calDayNo},
            startTime: "${c.calanderStartTime}"
          }<c:if test="${!s.last}">,</c:if>
        </c:if>
      </c:forEach>
    ];
    
    if (calList.length) {
      kakao.maps.load(() => {
        const map = new kakao.maps.Map(document.getElementById('map'), {
          center: new kakao.maps.LatLng(calList[0].lat, calList[0].lon),
          level: 6
        });
        
        // 마커 생성
        calList.forEach(loc => {
          const marker = new kakao.maps.Marker({
            map,
            position: new kakao.maps.LatLng(loc.lat, loc.lon),
            title: loc.name
          });
          const info = new kakao.maps.InfoWindow({
            content: `<div style="padding:5px;">${loc.name}</div>`
          });
          kakao.maps.event.addListener(marker, 'click', () => info.open(map, marker));
        });
        
        // Day별로 그룹화하여 연결선 그리기
        const dayGroups = {};
        calList.forEach(loc => {
          if (!dayGroups[loc.dayNo]) {
            dayGroups[loc.dayNo] = [];
          }
          dayGroups[loc.dayNo].push(loc);
        });
        
        // 각 Day별로 시간순 정렬 후 연결선 그리기
        const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD', '#98D8C8'];
        let colorIndex = 0;
        
        Object.keys(dayGroups).forEach(dayNo => {
          const dayLocations = dayGroups[dayNo];
          
          // 시간순으로 정렬
          dayLocations.sort((a, b) => {
            return a.startTime.localeCompare(b.startTime);
          });
          
          // 연결선 그리기
          if (dayLocations.length > 1) {
            const linePath = dayLocations.map(loc => 
              new kakao.maps.LatLng(loc.lat, loc.lon)
            );
            
            const polyline = new kakao.maps.Polyline({
              path: linePath,
              strokeWeight: 3,
              strokeColor: colors[colorIndex % colors.length],
              strokeOpacity: 0.7,
              strokeStyle: 'solid'
            });
            
            polyline.setMap(map);
            colorIndex++;
          }
        });
        
        // 전체 일정을 포함하도록 지도 범위 조정
        if (calList.length > 1) {
          const bounds = new kakao.maps.LatLngBounds();
          calList.forEach(loc => {
            bounds.extend(new kakao.maps.LatLng(loc.lat, loc.lon));
          });
          map.setBounds(bounds);
        }
      });
    }
  </script>
        
        <!-- -------------------------------------------------------------------------------------- -->
        
<hr/>

        <!-- 본문 -->
        <div class="card-text" style="white-space:pre-wrap;">
          ${editor.planContent}
        </div>

<br/><br/>

		<!-- 좋아요 버튼만 가운데 정렬 -->
		<p class="text-center mb-4">
		  <button type="button"
		          id="likeBtn"
		          class="btn-like ${liked ? 'liked' : ''}"
		          data-like-plan-id="${editor.planId}"
		          data-like-user-id="${loginId}"
				  onclick="likeToggle(this.dataset.likePlanId, this.dataset.likeUserId)">
		    <i id="likeIcon"
		       class="${liked ? 'fas' : 'far'} fa-heart"></i>
		    <span id="likeCount">${editor.planRecommend}</span>
		  </button>
		</p>
        
        <hr class="my-4"/>
        
        <p class="text-muted mb-4">
        댓글수: ${editor.comCount}
        </p>

<!-- 좋아요 토글 -->
<script>
  function likeToggle(likePlanId, likeUserId) {

    // 로그인체크
    if (!likeUserId)
    {
    	alert("로그인이 필요합니다.");
    	return;
    }

    fetch('/editor/likeToggle', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'likePlanId=' + encodeURIComponent(likePlanId) +
      		'&likeUserId=' + encodeURIComponent(likeUserId)
    })
    .then(r => r.json())
    .then(res => {
      // ⬇️ code(=0) 기준으로 메시지 분기
      if (res.code === 0)
      {
       	alert("좋아요");
      }
      else if(res.code === -1)
      {
		alert("안좋아요");
	  }
      else {
        alert("뭘까요이건: " + res.code);
      }
      // 무조건 새로고침
      location.reload();
    })
    .catch(() => {
      alert('서버 오류가 발생했습니다.');
      location.reload();
    });
  }
</script>

<c:if test="${loginId != null && loginId != ''}">
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

</c:if>

<br />
<!-- ★↓↓↓ 댓글 목록 루프 --------------------------------------- -->
<c:forEach var="c" items="${list}">
  <div class="border rounded p-3 mb-2">
    <!-- 한 줄 세로 정렬: 내용(왼쪽) · 버튼(오른쪽) -->
    <div class="d-flex justify-content-between align-items-start">
      <!-- 댓글 본문 -->
      <p class="mb-1 flex-grow-1 me-3"
      id="comment-${c.commentId}">
      ${c.planCommentContent}
      </p>

      <!-- 댓글삭제 버튼 -->
      <div class="btn-group btn-group-sm" role="group">
      
<c:if test="${loginId eq c.userId}">
        <!-- 삭제 -->
        <button type="button"
                class="btn btn-outline-dark"
                data-id="${c.commentId}"
                onclick="deleteComment(this.dataset.id)">
          삭제
        </button>
        
<!-- 댓글 삭제 -->
<script>
  function deleteComment(id) {

    // ☑️ 한번 더 확인
    if (!confirm('정말 삭제할까요?')) return;

    /* ※ 컨트롤러가 GET이면 method:'GET' + 쿼리스트링으로.
       지금은 POST 예시 ─ 컨트롤러 @PostMapping("/editor/commentDelete") 라고 가정 */
    fetch('/editor/commentDelete', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'commentId=' + encodeURIComponent(id)
    })
    .then(r => r.json())
    .then(res => {
      // ⬇️ code(=0) 기준으로 메시지 분기
      if (res.code === 0) {
        alert("삭제되었습니다.");
      } else {
        alert("삭제되지 않았습니다.");
      }
      // 무조건 새로고침
      location.reload();
    })
    .catch(() => {
      alert('서버 오류가 발생했습니다.');
      location.reload();
    });
  }
</script>

<form id="delForm" method="post" action="/editor/commentDelete">
  <input type="hidden" name="commentId">
  <!-- (Spring Security) -->
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>

</c:if>
        
      </div>
    </div>

    <!-- 메타 정보 -->
    <small class="text-muted">
      작성자: ${c.userName} | 날짜: ${c.planCommentDate}
    </small>
    
  </div>
</c:forEach>


<!-- ★↓↓↓ 댓글이 없을 때 --------------------------------------- -->
<c:if test="${empty list}">
  <div class="text-muted">등록된 댓글이 없습니다.</div>
</c:if>
<!-- ★↑↑↑ 끝 ---------------------------------------------------- -->

<br /><br />

      </div><!-- /card-body -->
    </div><!-- /card -->

  </div><!-- /container -->

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
