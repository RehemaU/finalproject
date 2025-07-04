<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
  <title>마이페이지</title>
  <style>
    .mypage-container {
	  display: flex;
	  max-width: 1450px;   /* 적당히 조절 가능 */
	  margin: 0 auto;      /* 가운데 정렬 */
	  min-height: 80vh;
	  border: 1px solid #ddd;
	  box-sizing: border-box;
    }
    .menu {
      width: 200px;
      background: #f8f8f8;
      border-right: 1px solid #ddd;
      display: flex;
      flex-direction: column;
    }
    .menu button {
      border: none;
      background: transparent;
      padding: 15px 20px;
      text-align: left;
      cursor: pointer;
      font-size: 16px;
    }
    .menu button:hover {
      background: #eee;
    }
    .content {
      flex-grow: 1;
      padding: 40px;
    }
  </style>
  <script>
    function loadContent(type) {
      let contentDiv = document.getElementById("contentArea");
      
      if(type === 'profile') {
          fetch('/user/userUpdateForm')
          .then(response => response.text())
          .then(html => {
            contentDiv.innerHTML = html;
          })
          .catch(error => {
            console.error(error);
            contentDiv.innerHTML = "<p>불러오기 실패</p>";
          });
      }
      
      else if(type === 'likes') {
        contentDiv.innerHTML = "<h2>내 찜 목록</h2><p>여기에 찜한 상품이나 게시글을 보여줄거야.</p>";
      }
      
      else if(type === 'posts') {
        fetch('/user/myplan')
          .then(response => response.text())
          .then(html => {
            contentDiv.innerHTML = html;
          })
          .catch(error => {
            console.error(error);
            contentDiv.innerHTML = "<p>불러오기 실패</p>";
          });
      }
      
      else if(type === 'comments') {
          fetch('/user/mycomment')
          .then(response => response.text())
          .then(html => {
            contentDiv.innerHTML = html;
          })
          .catch(error => {
            console.error(error);
            contentDiv.innerHTML = "<p>불러오기 실패</p>";
          });
      }
    }
  </script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
  <div class="mypage-container">
    <div class="menu">
      <button onclick="loadContent('profile')">마이 프로필</button>
      <button onclick="loadContent('likes')">내 찜 목록</button>
      <button onclick="loadContent('posts')">내가 쓴 게시글</button>
      <button onclick="loadContent('comments')">내 댓글</button>
      <!-- 필요한 메뉴 계속 추가 가능 -->
    </div>
    <div class="content" id="contentArea">
      <h2>마이페이지에 오신 것을 환영합니다!</h2>
      <p>왼쪽 메뉴를 선택하세요.</p>
    </div>
  </div>
</body>
</html>
