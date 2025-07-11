<!-- /WEB-INF/views/include/seller_nav.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- /WEB-INF/views/include/sellerNavigation.jsp -->
<header class="top-nav">
  <div class="logo">MY TRIP SELLER</div>
  <div class="nav-right">
    <c:choose>
      <c:when test="${not empty sessionScope.sellerId}">
        <a href="/seller/sellerUpdateForm">내 정보</a>
        <a href="/seller/loginOut">로그아웃</a>
      </c:when>
      <c:otherwise>
        <a href="/seller/login">로그인</a>
      </c:otherwise>
    </c:choose>
  </div>
</header>

<div class="admin-container">
  <aside class="sidebar">
    <h2>대시보드</h2>
    <ul>
      <li><a href="/accomm/accommRegForm">숙소 등록</a></li>
      <li><a href="/seller/accommList">숙소 목록</a></li>
      <li><a href="/seller/room/add">객실 등록</a></li>
      <li><a href="/seller/reservation/list">정산 내역</a></li>
    </ul>
  </aside>

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    background: #fff;
    color: #111;
  }

  .top-nav {
    height: 60px;
    background-color: #000;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
  }

  .top-nav .logo {
    font-size: 20px;
    font-weight: bold;
  }

  .top-nav .nav-right a {
    color: #fff;
    text-decoration: none;
    margin-left: 24px;
    font-size: 14px;
  }

  .top-nav .nav-right a:hover {
    text-decoration: underline;
  }

  .admin-container {
    display: flex;
    min-height: calc(100vh - 60px);
  }

  .sidebar {
    width: 240px;
    background-color: #000;
    color: #fff;
    padding: 32px 20px;
  }

  .sidebar h2 {
    font-size: 18px;
    margin-bottom: 32px;
    font-weight: bold;
  }

  .sidebar ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .sidebar li {
    margin-bottom: 20px;
  }

  .sidebar a {
    color: #fff;
    text-decoration: none;
    font-size: 15px;
    display: block;
    padding: 8px 12px;
    border-radius: 6px;
    transition: background 0.2s;
  }

  .sidebar a:hover {
    background: #222;
  }
</style>

