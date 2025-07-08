<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매자 관리</title>
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
        .approve-btn {
            background-color: #1ab394;
            color: white;
        }
        .cancel-btn {
            background-color: #d9534f;
            color: white;
        }
    </style>
</head>
<body>

<h2>판매자 관리</h2>

<table>
  <thead>
    <tr>
      <th>아이디</th>
      <th>이름</th>
      <th>이메일</th>
      <th>전화번호</th>
      <th>사업자번호</th>
      <th>상태</th>
      <th>관리</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="seller" items="${sellerList}">
      <tr data-seller-id="${seller.sellerId}">
        <td>${seller.sellerId}</td>
        <td>${seller.sellerName}</td>
        <td>${seller.sellerEmail}</td>
        <td>${seller.sellerNumber}</td>
        <td>${seller.sellerBusiness}</td>
        <td class="seller-status">
  <c:choose>
    <c:when test="${seller.sellerStatus == 'Y'}">승인 완료</c:when>
    <c:otherwise>대기중</c:otherwise>
  </c:choose>
</td>
<td class="seller-button">
  <c:choose>
    <c:when test="${seller.sellerStatus == 'N'}">
      <button type="button" class="approve-btn" onclick="toggleSellerStatus('${seller.sellerId}', 'Y')">승인</button>
    </c:when>
    <c:when test="${seller.sellerStatus == 'Y'}">
      <button type="button" class="cancel-btn" onclick="toggleSellerStatus('${seller.sellerId}', 'N')">승인 취소</button>
    </c:when>
  </c:choose>
</td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function toggleSellerStatus(sellerId, newStatus) {
    const message = newStatus === 'Y' 
        ? "해당 판매자를 승인하시겠습니까?" 
        : "해당 판매자 승인을 취소하시겠습니까?";

    if (!confirm(message)) return;

    $.ajax({
        url: "/admin/toggleSellerStatus",
        type: "POST",
        data: {
            sellerId: sellerId,
            status: newStatus
        },
        success: function(res) {
            if (res.code === 0) {
                alert("처리 완료!");

                // ✅ 부분 DOM 갱신
                const $row = $("tr[data-seller-id='" + sellerId + "']");
                const $statusCell = $row.find(".seller-status");
                const $buttonCell = $row.find(".seller-button");

                if (newStatus === 'Y') {
                    $statusCell.text("승인 완료");
                    $buttonCell.html(`<button type="button" class="cancel-btn" onclick="toggleSellerStatus('${sellerId}', 'N')">승인 취소</button>`);
                } else {
                    $statusCell.text("대기중");
                    $buttonCell.html(`<button type="button" class="approve-btn" onclick="toggleSellerStatus('${sellerId}', 'Y')">승인</button>`);
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
</script>

</body>
</html>
