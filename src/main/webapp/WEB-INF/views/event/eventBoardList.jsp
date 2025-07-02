<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>이벤트 게시판</title>
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

        .search-form {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
        }

        .search-form input,
        .search-form button {
            padding: 6px 10px;
            font-size: 14px;
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

        .no-result {
            text-align: center;
            padding: 40px;
            display: none;
        }

        .no-result img {
            width: 60px;
            margin-bottom: 10px;
        }

        .no-result span {
            font-size: 16px;
            color: #666;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="container">
    <h2>이벤트 게시판 <span class="total-count">총 <c:out value="${totalCount}"/>건</span></h2>

    <form id="searchForm" class="search-form" onsubmit="return false;">
        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력해주세요" />
        <button type="submit">검색</button>
    </form>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th class="col-narrow">조회수</th>
                <th class="col-narrow">작성일</th>
            </tr>
        </thead>
        <tbody id="eventTableBody">
            <c:forEach var="event" items="${eventList}" varStatus="status">
                <tr>
                    <td>${totalCount - (curPage - 1) * pageSize - status.index}</td>
                    <td class="title-col">
                        <a href="/event/view?eventId=${event.eventId}">
                            <c:out value="${event.eventTitle}" />
                        </a>
                    </td>
                    <td>${event.eventCount}</td>
                    <td>${event.eventRegdate.substring(0, 10)}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 검색 결과 없음 메시지 -->
    <div id="noResultDiv" class="no-result">
        
        <br>
        <span>검색 결과가 없습니다.</span>
    </div>

    <!-- 페이지네이션 -->
    <div class="pagination" id="paginationDiv">
        <c:if test="${curPage > 1}">
            <a href="?page=${curPage - 1}">이전</a>
        </c:if>

        <c:forEach begin="1" end="${totalPage}" var="i">
            <a href="?page=${i}" class="${i == curPage ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:if test="${curPage < totalPage}">
            <a href="?page=${curPage + 1}">다음</a>
        </c:if>
    </div>
</div>

<script>
function fetchSearchResults(page = 1) {
    const keyword = $("#searchKeyword").val().trim();

    $.ajax({
        type: "GET",
        url: "/event/ajaxSearch",
        data: {
            searchKeyword: keyword,
            page: page
        },
        success: function(res) {
            if (res.tableHtml.trim() === "") {
                $("#eventTableBody").empty();
                $("#paginationDiv").empty();
                $("#noResultDiv").show();
            } else {
                $("#eventTableBody").html(res.tableHtml);
                $("#paginationDiv").html(res.paginationHtml);
                $("#noResultDiv").hide();
                bindPaginationClick();
            }
        },
        error: function() {
            // 검색 실패 시에도 조용히 결과 없음 이미지 표시
            $("#eventTableBody").empty();
            $("#paginationDiv").empty();
            $("#noResultDiv").show();
        }
    });
}

function bindPaginationClick() {
    $("#paginationDiv a").off("click").on("click", function(e) {
        e.preventDefault();
        const page = new URLSearchParams($(this).attr("href").split("?")[1]).get("page");
        fetchSearchResults(page);
    });
}

$(document).ready(function() {
    $("#searchForm").on("submit", function() {
        fetchSearchResults(1); // 첫 검색은 1페이지
    });

    bindPaginationClick(); // 최초 페이지 로딩 시에도 바인딩
});
</script>

</body>
</html>
