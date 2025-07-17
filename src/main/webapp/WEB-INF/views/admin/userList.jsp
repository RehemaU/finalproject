<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        button {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .ban-btn {
            background-color: #d9534f;
            color: white;
        }
        .unban-btn {
            background-color: #1ab394;
            color: white;
        }
           .pagination {
       margin-top: 20px;
       text-align: center;
      }
      
      .pagination a {
          display: inline-block;
          margin: 0 4px;
          padding: 6px 12px;
          text-decoration: none;
          border: 1px solid #ccc;
          color: #333;
          border-radius: 4px;
          font-size: 14px;
          background-color: #f9f9f9;
          transition: all 0.2s;
      }
      
      .pagination a:hover {
          background-color: #e0e0e0;
      }
      
      .pagination a.active {
          background-color: #1ab394;
          color: white;
          font-weight: bold;
          border-color: #1ab394;
      }
    </style>
</head>
<body>
<div style="margin-bottom: 15px;">
    <input type="text" id="userSearchInput" value="${keyword}" placeholder="아이디 검색" style="padding: 5px;">
    <button id="userSearchBtn" style="padding: 5px 10px;">검색</button>
</div>
<div id="userTableArea">
    <table>
  <thead>
  
    <tr>
      <th>아이디</th>
      <th>이름</th>
      <th>이메일</th>
      <th>전화번호</th>
      <th>가입일</th>
      <th>상태</th>
      <th>관리</th>
    </tr>
  </thead>
  <tbody>
  
    <c:forEach var="user" items="${userList}">
      <tr data-user-id="${user.userId}">
        <td>${user.userId}</td>
        <td>${user.userName}</td>
        <td>${user.userEmail}</td>
        <td>${user.userNumber}</td>
        <td>${user.userRegdate}</td>
        <td class="user-status">
          <c:choose>
            <c:when test="${user.userOut == 'Y'}">탈퇴</c:when>
            <c:otherwise>정상</c:otherwise>
          </c:choose>
        </td>
<td class="user-button">
  <c:choose>
    <c:when test="${user.userOut == 'N'}">
      <button type="button"
              class="ban-btn toggle-user-btn"
              data-userid="${user.userId}"
              data-status="Y">탈퇴 처리</button>
    </c:when>
    <c:when test="${user.userOut == 'Y'}">
      <button type="button"
              class="unban-btn toggle-user-btn"
              data-userid="${user.userId}"
              data-status="N">복구</button>
    </c:when>
  </c:choose>
</td>
      </tr>
    </c:forEach>
    
  </tbody>
  
  
 </table>

    <div class="pagination" id="userPagination">
        <c:if test="${curPage > 1}">
            <a href="javascript:void(0);" class="user-page-link" data-page="${curPage - 1}">« 이전</a>
        </c:if>

        <c:forEach begin="1" end="${totalPage}" var="i">
            <c:choose>
                <c:when test="${i == curPage}">
                    <a href="javascript:void(0);" class="user-page-link active" data-page="${i}">${i}</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0);" class="user-page-link" data-page="${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${curPage < totalPage}">
            <a href="javascript:void(0);" class="user-page-link" data-page="${curPage + 1}">다음 »</a>
        </c:if>
    </div>
</div>
