<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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

<h2>판매자 관리</h2>

<div style="margin-bottom: 15px;">
    <input type="text" id="sellerSearchInput" placeholder="아이디 검색" style="padding: 5px;">
    <button onclick="searchSeller()" style="padding: 5px 10px;">검색</button>
</div>

<table>
  <thead>
    <tr>
      <th>아이디</th>
      <th>이름</th>
      <th>이메일</th>
      <th>전화번호</th>
      <th>기업명</th>
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

<!-- ✅ 페이징 -->
<div class="pagination" id="paginationDiv">
  <c:if test="${curPage > 1}">
    <a href="javascript:void(0);" class="seller-page-link" data-page="${curPage - 1}">« 이전</a>
  </c:if>
  <c:forEach begin="1" end="${totalPage}" var="i">
    <a href="javascript:void(0);" class="seller-page-link ${i == curPage ? 'active' : ''}" data-page="${i}">${i}</a>
  </c:forEach>
  <c:if test="${curPage < totalPage}">
    <a href="javascript:void(0);" class="seller-page-link" data-page="${curPage + 1}">다음 »</a>
  </c:if>
</div>
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

// ✅ 판매자 목록 조회
function fetchSellerList(page = 1) {
    const keyword = $('#sellerSearchInput').val();

    $.ajax({
        url: '/admin/sellerList',
        type: 'GET',
        data: {
            keyword: keyword,
            page: page
        },
        success: function (res) {
            $('#contentArea').html(res);
        },
        error: function () {
            alert('데이터 로딩 실패');
        }
    });
}

// ✅ 페이지 링크 클릭
$(document).off('click', '.seller-page-link')  // 기존 이벤트 제거
           .on('click', '.seller-page-link', function () {
               const page = $(this).data('page');
               fetchSellerList(page);
           });

// ✅ 검색 버튼 클릭
function searchSeller() {
    fetchSellerList(1);
}
</script>

</body>
</html>
