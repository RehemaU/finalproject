<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
    Date now = new Date();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이벤트 관리</title>
    <style>
        .top-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        #eventTable {
            width: 100%;
            border-collapse: collapse;
        }
        #eventTable th, #eventTable td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        #eventTable th {
            background-color: #f5f5f5;
        }
        .title-cell {
            text-align: left;
            padding-left: 10px;
        }
        .edit-btn { background-color: #f0ad4e; color: white; }
        .delete-btn { background-color: #d9534f; color: white; }
        .write-btn {
            background-color: #5cb85c;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .filter-btn {
            padding: 6px 12px;
            margin-left: 5px;
            background-color: #eee;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
        .filter-btn:hover {
            background-color: #ddd;
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="container">
    <h2>이벤트 관리</h2>

    <div class="top-bar">
        <div>
            <input type="text" id="adminEventSearchInput" placeholder="제목 검색..." />
            <button id="adminEventSearchBtn">검색</button>
            <button class="filter-btn" data-status="active">진행 중 이벤트</button>
            <button class="filter-btn" data-status="closed">종료된 이벤트</button>
        </div>
        <button id="openEventWriteBtn" class="write-btn" type="button">+ 작성</button>
    </div>

    <table id="eventTable">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>쿠폰</th>
                <th>상태</th>
                <th>작성일</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody id="eventTableBody">
            <c:forEach var="event" items="${eventList}">
                <tr>
                    <td>${event.eventId}</td>
                    <td class="title-cell">
                        <a href="/event/eventDetail?eventId=${event.eventId}" target="_blank">
                            ${event.eventTitle}
                        </a>
                    </td>
                    <td>${event.couponId}</td>
<td>
    <%
        String endDateStr = (String) pageContext.findAttribute("event").getClass().getMethod("getEventEnddate").invoke(pageContext.findAttribute("event"));
        Date endDate = sdf.parse(endDateStr);

        if (endDate.compareTo(now) >= 0) {
    %>
        진행 중
    <%
        } else {
    %>
        종료됨
    <%
        }
    %>
</td>


                    <td>${event.eventRegdate.substring(0, 10)}</td>
                    <td>
                        <button class="edit-btn" onclick="loadEventUpdateForm('${event.eventId}')">수정</button>
                        <button class="delete-btn" onclick="deleteEvent('${event.eventId}')">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

<div class="pagination" id="eventPagination" style="text-align:center; margin-top:20px;">
    <c:if test="${blockStart > 1}">
        <a href="javascript:void(0);" class="event-page-link" data-page="${blockStart - 1}">« 이전</a>
    </c:if>

    <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
        <c:choose>
            <c:when test="${i == curPage}">
                <a href="javascript:void(0);" class="event-page-link active" data-page="${i}">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="javascript:void(0);" class="event-page-link" data-page="${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${blockEnd < totalPage}">
        <a href="javascript:void(0);" class="event-page-link" data-page="${blockEnd + 1}">다음 »</a>
    </c:if>
</div>



<script>
let currentStatus = "active";

function fetchAdminEventList(page = 1) {
    const keyword = $("#adminEventSearchInput").val().trim();

    $.ajax({
        type: "GET",
        url: "/admin/eventAjaxList",
        data: {
            searchKeyword: keyword,
            page: page,
            status: currentStatus
        },
        success: function(res) {
            if (res.tableHtml.trim() === "") {
                $("#eventTableBody").empty();
                $("#eventPagination").empty();
                $("#noResultDiv").show();
            } else {
                $("#eventTableBody").html(res.tableHtml);
                $("#eventPagination").html(res.paginationHtml);
                $("#noResultDiv").hide();
                bindPaginationClick();
            }
        },
        error: function() {
            alert("이벤트 목록 불러오기 실패");
        }
    });
}

function bindPaginationClick() {
    $("#eventPagination a").off("click").on("click", function(e) {
        e.preventDefault();
        const page = new URLSearchParams($(this).attr("href").split("?")[1]).get("page");
        fetchAdminEventList(page);
    });
}

$(document).ready(function () {
    $("#adminEventSearchBtn").on("click", function() {
        fetchAdminEventList(1);
    });

    $(".filter-btn").on("click", function() {
        const status = $(this).data("status");
        const keyword = $("#searchKeyword").val();
        location.href = "/admin/eventList?page=1&status=" + status + "&keyword=" + encodeURIComponent(keyword);
    });

    $("#eventWriteBtn").on("click", function () {
        $.ajax({
            url: "/admin/eventWriteForm",
            type: "GET",
            success: function (res) {
                $("#eventContent").html(res);
            },
            error: function () {
                alert("작성 폼 로딩 실패");
            }
        });
    });
});
</script>

</body>
</html>
