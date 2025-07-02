<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- 스타일 & 레이아웃 생략 : 이전 likeList.jsp 그대로 -->

<div class="container">
  <h2>❤️ 내가 좋아요한 장소</h2>

  <c:choose>
    <c:when test="${empty likedList}">
      <p style="text-align:center;">좋아요한 장소가 없습니다.</p>
    </c:when>
    <c:otherwise>
      <div class="card-grid">
        <c:forEach var="item" items="${likedList}">
          <div class="card">
            <c:if test="${not empty item.IMAGE}">
              <img src="${item.IMAGE}" alt="image">
            </c:if>
            <div class="card-content">
              <h3>${item.NAME}</h3>
              <p>${item.ADDRESS}</p>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>
