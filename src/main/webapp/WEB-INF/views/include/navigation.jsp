<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- navigation.jsp : 공통 Header / GNB -->
<header>
  <!-- 상단 유틸바 -->
  <div class="util-bar wrap flex between center">
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

  <!-- 메인 태그라인 -->
  <div class="tagline wrap">
    <a class="tag-item" href="/walkthrough">Walkthrough</a>
    <a class="tag-item" href="/tour/list">Explore</a>
    <a class="tag-item" href="/accomm/list">Stay</a>
    <a class="tag-item" href="/schedule/addList"">Plan</a>
    <a class="tag-item" href="/editor/planmenu">Share</a>
  </div>

  <!-- GNB -->
  <nav class="gnb wrap flex center">
    <a href="/tour/list">TOUR</a><a href="/accomm/list">STAY</a><a href="/schedule/addList">SCHEDULE</a>


    <a href="/editor/planmenu">REVIEW</a><a href="/notice/noticeList">NOTICE</a><a href="/event/eventList">EVENT</a><a href="/weather">WEATHER</a>


  </nav>
</header>