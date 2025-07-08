<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
<!-- 상단 util-bar -->
<div class="util-bar" style="
    position:fixed;
    top:0;
    left:0;
    right:0;
    height:60px;
    background:white;
    z-index:1000;
    border-bottom:1px solid #ddd;">
  <div class="wrap flex between center" style="max-width:1200px; margin:0 auto; height:100%; padding:0 20px;">
    <a href="/" class="logo">logo</a>
    <div class="util-icons flex center">
      <a class="icon" href="/mypage/main">MY PAGE</a>
      <a class="icon" href="/like/list">MY LIKE</a>
      <a class="icon" href="/bag">BAG</a>
      <c:choose>
        <c:when test="${not empty sessionScope.userId}">
          <a class="icon" href="/user/loginOut">LOGOUT</a>
        </c:when>
        <c:otherwise>
          <a class="icon" href="/user/login">LOGIN</a>
        </c:otherwise>
      </c:choose>
      <span class="search" aria-label="Search"></span>
    </div>
  </div>
</div>

  <!-- 태그라인 + GNB : hide/show 대상 -->
  <div class="header-sub" style="position:fixed; top:60px; left:0; right:0; z-index:999; background:white; transition:top 0.3s;">
    <div class="tagline wrap">
      <a class="tag-item" href="/walkthrough">Walkthrough</a>
      <a class="tag-item" href="/tour/list">Explore</a>
      <a class="tag-item" href="/accomm/list">Stay</a>
      <a class="tag-item" href="/schedule/addList">Plan</a>
      <a class="tag-item" href="/editor/planmenu">Share</a>
    </div>

    <nav class="gnb wrap flex center">
      <a href="/tour/list">TOUR</a>
      <a href="/accomm/list">STAY</a>
      <a href="/schedule/addList">SCHEDULE</a>
      <a href="/editor/planmenu">REVIEW</a>
      <a href="/notice/noticeList">NOTICE</a>
      <a href="/event/eventList">EVENT</a>
      <a href="/weather">WEATHER</a>
    </nav>
  </div>
</header>

<!-- 본문 여백 확보 -->
<style>
  body {
    margin-top: 120px; /* util-bar 60 + header-sub 대략 60 */
    padding: 20px;
  }
</style>

<script>
  window.addEventListener("scroll", function() {
    const currentScrollPos = window.pageYOffset;
    const headerSub = document.querySelector(".header-sub");

    if (currentScrollPos === 0) {
      // 스크롤이 맨 위일 때만 보여줌
      headerSub.style.top = "60px";
    } else {
      // 그 외에는 숨김
      headerSub.style.top = "-100px";
    }
  });
</script>
