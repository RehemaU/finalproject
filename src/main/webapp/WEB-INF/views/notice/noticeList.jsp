<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 50px auto;
        }

        h2 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .total-count {
            font-size: 14px;
            color: #555;
        }

        table {
            width: 100%;
            border-top: 2px solid #333;
            border-collapse: collapse;
        }

        table th, table td {
            border-bottom: 1px solid #ddd;
            padding: 12px;
            font-size: 14px;
            text-align: center;
        }

        table th {
            background-color: #f5f5f5;
            font-weight: 600;
        }

        .title-col {
            text-align: left;
        }

        .col-narrow {
            width: 100px;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            display: inline-block;
            padding: 6px 10px;
            margin: 0 3px;
            border: 1px solid #ccc;
            text-decoration: none;
            color: #333;
            font-size: 13px;
        }

        .pagination a.active {
            background-color: #333;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>공지사항 <span class="total-count">총 <span id="totalCountText"><c:out value="${totalCount}"/></span>건</span></h2>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th class="col-narrow">조회수</th>
                <th class="col-narrow">등록일</th>
            </tr>
        </thead>
        <tbody id="noticeTableBody">
    <c:forEach var="notice" items="${noticeList}" varStatus="status">
        <tr>
            <td>${totalCount - status.index}</td>
            <td class="title-col">
                <a href="/notice/noticeDetail?noticeId=${notice.noticeId}">
                    <c:out value="${notice.noticeTitle}" />
                </a>
            </td>
            <td><c:out value="${notice.noticeCount}" /></td>
            <td><c:out value="${notice.noticeRegdate.substring(0,10)}" /></td>
        </tr>
    </c:forEach>
</tbody>
    </table>

    <!-- 페이지네이션 -->
    
	<div class="pagination" id="paginationDiv">
	    <c:if test="${currentPage > 1}">
	  <a href="?page=${currentPage - 1}">이전</a>
	</c:if>
	<c:forEach begin="1" end="${totalPage}" var="i">
	  <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
	</c:forEach>
	<c:if test="${currentPage < totalPage}">
	  <a href="?page=${currentPage + 1}">다음</a>
	</c:if>
	</div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function fetchNoticePage(page = 1) {
    $.ajax({
        type: "GET",
        url: "/notice/ajaxSearch",
        data: { page: page },
        success: function(res) {
            $("#noticeTableBody").html(res.tableHtml);
            $("#paginationDiv").html(res.paginationHtml);
        },
        error: function() {
            alert("공지사항을 불러오는 데 실패했습니다.");
        }
    });
}

function bindPaginationClick() {
    $("#paginationDiv").on("click", "a", function(e) {
        e.preventDefault();
        const page = new URLSearchParams($(this).attr("href").split("?")[1]).get("page");
        fetchNoticePage(page);
    });
}

$(document).ready(function() {
    bindPaginationClick();
});
</script>

</body>
</html>
