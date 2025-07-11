<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>판매자 정보 관리</title>
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
    }

    .profile-hub {
      max-width: 600px;
      margin: 80px auto;
      background: #fff;
      border: 1px solid #e5e5e5;
      border-radius: 12px;
      padding: 40px;
      text-align: center;
      box-shadow: 0 4px 20px rgba(0,0,0,0.05);
    }

    .profile-hub h2 {
      font-size: 24px;
      margin-bottom: 32px;
      border-bottom: 2px solid #111;
      padding-bottom: 10px;
    }

    .profile-hub .btn {
      display: inline-block;
      margin: 12px;
      padding: 12px 24px;
      background-color: #000;
      color: #fff;
      border-radius: 6px;
      font-weight: 600;
      font-size: 15px;
      text-decoration: none;
      transition: background 0.3s;
    }

    .profile-hub .btn:hover {
      background-color: #222;
    }
  </style>
</head>
<body>
  <div class="profile-hub">
    <h2>판매자 정보 관리</h2>
    
    <a href="/seller/sellerUpdateForm" class="btn">내 정보 수정</a>
    <a href="/seller/sellerPasswordForm" class="btn">비밀번호 변경</a>
    <a href="/seller/accomm/list" class="btn">숙소 관리</a>
    <a href="/seller/reservation/list" class="btn">정산 내역 보기</a>
  </div>
</body>
</html>
