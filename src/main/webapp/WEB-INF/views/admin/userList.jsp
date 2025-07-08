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
    </style>
</head>
<body>

<h2>회원 관리</h2>

<div style="margin-bottom: 15px;">
    <input type="text" id="userSearchInput" placeholder="아이디 검색" style="padding: 5px;">
    <button onclick="searchUser()" style="padding: 5px 10px;">검색</button>
</div>

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
              <button type="button" class="ban-btn" onclick="toggleUserOut('${user.userId}', 'Y')">탈퇴 처리</button>
            </c:when>
            <c:when test="${user.userOut == 'Y'}">
              <button type="button" class="unban-btn" onclick="toggleUserOut('${user.userId}', 'N')">복구</button>
            </c:when>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function toggleUserOut(userId, newStatus) {
    const message = newStatus === 'Y' 
        ? "해당 회원을 탈퇴 처리하시겠습니까?" 
        : "해당 회원을 복구하시겠습니까?";

    if (!confirm(message)) return;

    $.ajax({
        url: "/admin/toggleUserStatus",
        type: "POST",
        data: {
            userId: userId,
            status: newStatus
        },
        success: function(res) {
            if (res.code === 0) {
                alert("처리 완료!");
                const $row = $("tr[data-user-id='" + userId + "']");
                const $statusCell = $row.find(".user-status");
                const $buttonCell = $row.find(".user-button");

                if (newStatus === 'Y') {
                    $statusCell.text("탈퇴");
                    $buttonCell.html(`<button type="button" class="unban-btn" onclick="toggleUserOut('${userId}', 'N')">복구</button>`);
                } else {
                    $statusCell.text("정상");
                    $buttonCell.html(`<button type="button" class="ban-btn" onclick="toggleUserOut('${userId}', 'Y')">탈퇴 처리</button>`);
                }
            } else {
                alert("처리 실패. 다시 시도해주세요.");
            }
        },
        error: function() {
            alert("서버 오류가 발생했습니다.");
        }
    });
}
  
function searchUser() {
    const keyword = $('#userSearchInput').val();

    $.ajax({
        url: '/admin/userList',
        type: 'GET',
        data: { keyword: keyword },
        success: function (res) {
            $('#contentArea').html(res); // 관리자 대시보드에서 이 영역에 다시 덮어씀
        },
        error: function () {
            alert('검색에 실패했습니다.');
        }
    });
}
    
    
    
</script>

</body>
</html>
