<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<div class="event-list">
    <c:forEach var="event" items="${eventList}">
        <a href="/event/eventDetail?eventId=${event.eventId}" class="event-box">
            <img src="${pageContext.request.contextPath}${event.eventThumbnailUrl}" alt="이벤트 이미지">
            <div class="event-info">
                <div class="event-title">${event.eventTitle}</div>
                <div class="event-date">~ ${event.eventEnddate}</div>
            </div>
        </a>
    </c:forEach>
</div>

<!-- 페이징 영역 -->
<div class="paging" style="text-align:center; margin-top:20px;">
    <c:if test="${curPage > 1}">
        <a href="?page=${curPage - 1}">이전</a>
    </c:if>

    <c:forEach begin="1" end="${totalPage}" var="i">
        <a href="?page=${i}" style="${i == curPage ? 'font-weight:bold;' : ''}">${i}</a>
    </c:forEach>

    <c:if test="${curPage < totalPage}">
        <a href="?page=${curPage + 1}">다음</a>
    </c:if>
</div>
