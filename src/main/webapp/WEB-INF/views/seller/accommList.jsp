<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #fff;
    margin: 0;
    padding: 0;
  }

  main.wrap {
    max-width: 100%;
    padding: 40px 60px;
    box-sizing: border-box;
  }

  h2 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 24px;
  }

  .accomm-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .accomm-item {
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fafafa;
    padding: 12px 16px;
    height: 100px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.03);
  }

  .accomm-item img {
    width: 100px;
    height: 75px;
    object-fit: cover;
    border-radius: 4px;
    margin-right: 16px;
    flex-shrink: 0;
  }

  .accomm-info {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    width: 100%;
  }

  .accomm-texts {
    display: flex;
    flex-direction: column;
    gap: 4px;
  }

  .accomm-texts h3 {
    margin: 0;
    font-size: 16px;
    font-weight: 600;
  }

  .accomm-texts p {
    margin: 0;
    font-size: 13px;
    color: #444;
  }

</style>

<main class="wrap">
  <h2>내가 등록한 숙소</h2>
  <div class="accomm-list">
    <c:forEach var="accomm" items="${accommList}">
      <div class="accomm-item">
        <c:choose>
          <c:when test="${not empty accomm.firstImage}">
            <img src="${accomm.firstImage}" onerror="this.src='/resources/images/no-image.jpg'" alt="숙소 이미지">
          </c:when>
          <c:otherwise>
            <img src="/resources/images/no-image.jpg" alt="기본 이미지">
          </c:otherwise>
        </c:choose>
        <div class="accomm-info">
          <div class="accomm-texts">
            <h3>${accomm.accomName}</h3>
            <p>${accomm.accomAdd}</p>
            <p>상태: ${accomm.accomStatus} / 전화: ${accomm.accomTel}</p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</main>
