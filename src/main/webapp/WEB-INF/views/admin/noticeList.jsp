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
                    <a href="/admin/noticeView?noticeId=${notice.noticeId}">${notice.noticeTitle}</a>
                </td>
                <td>${notice.noticeCount}</td>
<td>${notice.noticeRegdate.substring(0, 10)}</td>
                <td>
                    <button class="edit-btn" data-id="${notice.noticeId}">수정</button>
                    <button class="delete-btn" data-id="${notice.noticeId}">삭제</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

    <!-- 페이징 -->
    <div id="noticePagination" style="text-align: center; margin-top: 20px;"></div>
</div>

<div id="noticeContent"></div>

<script>
$(document).ready(function () {
    if (typeof initNoticeEvents === 'function') {
        initNoticeEvents();  // ✅ 대시보드에서 삽입되면 호출됨
    }
});


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

$(document).on("click", "#updateNoticeBtn", function () {
    const noticeId = $("#noticeId").val();
    const title = $("#noticeTitle").val();
    const content = $("#noticeContent").val();

    if (title.trim() === "" || content.trim() === "") {
        alert("제목과 내용을 입력하세요.");
        return;
    }

    $.ajax({
        url: "/admin/noticeUpdate",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            noticeId: noticeId,
            noticeTitle: title,
            noticeContent: content
        }),
        success: function (res) {
            if (res.code === 0) {
                alert("수정 완료");
                loadContent("/admin/noticeList");
            } else {
                alert("수정 실패: " + res.msg);
            }
        },
        error: function () {
            alert("서버 오류");
        }
    });
});


</script>

</body>
</html>
