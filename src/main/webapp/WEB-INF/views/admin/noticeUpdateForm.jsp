<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="max-width: 700px; margin: 0 auto;">
    <h2>공지사항 수정</h2>

    <form id="noticeUpdateForm">
        <input type="hidden" id="noticeId" value="${notice.noticeId}" />

        <div style="margin-bottom: 15px;">
            <label for="noticeTitle">제목</label><br>
            <input type="text" id="noticeTitle" value="${notice.noticeTitle}" style="width: 100%; padding: 8px;" />
        </div>

        <div style="margin-bottom: 15px;">
            <label for="noticeContent">내용</label><br>
            <textarea id="noticeContent" rows="10" style="width: 100%; padding: 8px;">${notice.noticeContent}</textarea>
        </div>

        <button type="button" id="updateNoticeBtn" style="
            background-color: #f0ad4e;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        ">수정 완료</button>
    </form>
</div>
