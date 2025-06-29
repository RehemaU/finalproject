<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
  <%@ include file="/WEB-INF/views/include/editorhead.jsp" %>

  <!-- 페이지 전용 스타일 -->
  <style>
    .btn-wrap{
      max-width:800px;      /* 폭 제한 */
      margin:120px auto;    /* 화면 가운데 내려서 배치 */
      display:flex;
      gap:24px;
    }
    .big-btn{
      flex:1;
      height:160px;
      font-size:1.6rem;
      font-weight:700;
      border:none;
      border-radius:16px;
      color:#fff;
      cursor:pointer;
      transition:transform .2s, box-shadow .2s;
    }
    .big-btn:hover{transform:translateY(-4px); box-shadow:0 6px 16px rgba(0,0,0,.25);}
    .write-btn{background:#000;}     /* 검정 */
    .list-btn {background:#3d3d3d;}  /* 진회색(구분용) */
  </style>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <main>
  
  <br /><br /><br />
  
    <div class="btn-wrap">
      <!-- 왼쪽: 목록 -->
      <button class="big-btn list-btn" onclick="location.href='/editor/planlist'">
        후기&nbsp;목록
      </button>

      <!-- 오른쪽: 작성 -->
      <button class="big-btn write-btn" onclick="location.href='/editor/planeditor'">
        후기&nbsp;작성
      </button>
    </div>
  </main>
</body>
</html>
