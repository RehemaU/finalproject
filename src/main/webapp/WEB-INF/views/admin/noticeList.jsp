<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>
    <style>
        .top-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        #noticeTable {
            width: 100%;
            border-collapse: collapse;
        }
        #noticeTable th, #noticeTable td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        #noticeTable th {
            background-color: #f5f5f5;
        }
        .title-cell {
            text-align: left;
            padding-left: 10px;
        }
        .action-btn {
            padding: 4px 10px;
            margin: 0 2px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
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
        .noticepagination a {
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
        .noticepagination a:hover {
            background-color: #e0e0e0;
        }
        .noticepagination a.active {
            background-color: #1ab394;
            color: white;
            font-weight: bold;
            border-color: #1ab394;
        }
        
        
    </style>
</head>
<body> 

<div class="container">
    <h2>공지사항 관리</h2>

    <!-- 상단 검색/작성 -->
    <div class="top-bar">
        <div>
            <input type="text" id="noticeSearchInput" placeholder="제목 검색..." />
            <button id="noticeSearchBtn">검색</button>
        </div>
        <button id="noticeWriteBtn" class="write-btn" type="button">+ 작성</button>
    </div>

    <!-- 테이블 -->
<table id="noticeTable">
    <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>조회수</th>
            <th>작성일</th>
            <th>관리</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="notice" items="${noticeList}">
            <tr>
                <td>${notice.noticeId}</td>
                <td class="title-cell">
                    	<a href="javascript:void(0);"
					       class="notice-title-link"
					       data-notice-id="${notice.noticeId}">
					       ${notice.noticeTitle}
					    </a>
                </td>
                <td>${notice.noticeCount}</td>
<td>${notice.noticeRegdate.substring(0, 10)}</td>
                <td>
                    <button class="edit-btn notice-edit-btn" data-id="${notice.noticeId}">수정</button>
                    <button class="delete-btn notice-delete-btn" data-id="${notice.noticeId}">삭제</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

    <!-- 페이징 -->
    <div id="pagination" style="text-align:center; margin-top:20px;">
    <c:if test="${blockStart > 1}">
        <a href="javascript:void(0);" class="notice-page-link" data-page="${blockStart - 1}">« 이전</a>
    </c:if>

    <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
        <c:choose>
            <c:when test="${i == curPage}">
                <a href="javascript:void(0);" class="notice-page-link active" data-page="${i}">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="javascript:void(0);" class="notice-page-link" data-page="${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${blockEnd < totalPage}">
        <a href="javascript:void(0);" class="notice-page-link" data-page="${blockEnd + 1}">다음 »</a>
    </c:if>
</div>
</div>

<div id="noticeContent"></div>

<script>


$("#noticeWriteBtn").click(function () {
    $.ajax({
        url: "/admin/noticeWriteForm",
        type: "GET",
        success: function (res) {
            $("#noticeContent").html(res); // 아래 div에 폼 삽입
        },
        error: function () {
            alert("작성 폼 로딩 실패");
        }
    });
});




</script>

</body>
</html>
