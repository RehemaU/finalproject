<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <style>
    .mypage-container {
      max-width: 800px;
      margin: 50px auto;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 10px;
      box-shadow: 2px 2px 8px rgba(0,0,0,0.1);
      font-family: Arial, sans-serif;
    }
    .mypage-title {
      font-size: 28px;
      text-align: center;
      margin-bottom: 30px;
    }
    .mypage-menu {
      list-style: none;
      padding: 0;
    }
    .mypage-menu li {
      border-bottom: 1px solid #eee;
    }
    .mypage-menu li a {
      display: block;
      padding: 15px 20px;
      text-decoration: none;
      color: #333;
      transition: background 0.2s;
    }
    .mypage-menu li a:hover {
      background: #f0f0f0;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
  <div class="mypage-container">
    <h2 class="mypage-title">마이페이지</h2>
    <ul class="mypage-menu">
      <li><a href="/user/userUpdateForm">회원정보 (수정/탈퇴)</a></li>
      <li><a href="/schedule/myList">내가 쓴 일정</a></li>
      <li><a href="/mypage/planlist">내가 쓴 게시글</a></li>
      <li><a href="/mypage/commentlist">내가 쓴 댓글</a></li>
      <li><a href="/mypage/recommendlist">좋아요 누른 게시글</a></li>
      <li><a href="/mypage/favorite">찜한 장소</a></li>
      <li><a href="/mypage/cart">장바구니</a></li>
      <li><a href="/mypage/order">결제 내역</a></li>
      <li><a href="/mypage/cancel">취소 내역</a></li>
    </ul>
  </div>
</body>
</html>
