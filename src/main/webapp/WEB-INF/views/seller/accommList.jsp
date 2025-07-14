<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/sellerHead2.jsp" %>
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
    background-color: #f9f9f9;
  }

  h2 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 24px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
    text-align: left;
    background-color: #fff;
    box-shadow: 0 2px 8px rgba(0,0,0,0.03);
  }

  thead {
    background-color: #f4f4f4;
    border-top: 2px solid #000;
    border-bottom: 1px solid #ccc;
  }

  thead th {
    padding: 12px 16px;
  }

  tbody td {
    padding: 12px 16px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
  }

  .accomm-img {
    width: 80px;
    height: 60px;
    object-fit: cover;
    border-radius: 4px;
  }

  .small-text {
    font-size: 13px;
    color: #555;
  }
    .btn-view {
    display: inline-block;
    padding: 8px 16px;
    font-size: 13px;
    background-color: #000;
    color: #fff;
    border: none;
    border-radius: 6px;
    text-decoration: none;
    transition: background-color 0.2s ease;
  }

  .btn-view:hover {
    background-color: #333;
  }
</style>

<main class="wrap">
  <h2>내가 등록한 숙소</h2>

<table>
  <colgroup>
    <col style="width: 100px;">     <!-- 이미지 -->
    <col style="width: 180px;">     <!-- 숙소명 -->
    <col style="width: 300px;">     <!-- 주소 -->
    <col style="width: 140px;">     <!-- 전화번호 -->
    <col style="width: 100px;">     <!-- 상태 -->
    <col style="width: 120px;">     <!-- 객실 보기 -->
  </colgroup>
  <thead>
    <tr>
      <th>이미지</th>
      <th>숙소명</th>
      <th>주소</th>
      <th>전화번호</th>
      <th>승인여부</th>
      <th>객실</th>
    </tr>
  </thead>
    <tbody>
      <c:forEach var="accomm" items="${accommList}">
        <tr>
          <td>
            <c:choose>
              <c:when test="${not empty accomm.firstImage}">
                <img src="${accomm.firstImage}" onerror="this.src='/resources/images/no-image.jpg'" alt="숙소 이미지" class="accomm-img">
              </c:when>
              <c:otherwise>
                <img src="/resources/images/no-image.jpg" alt="기본 이미지" class="accomm-img">
              </c:otherwise>
            </c:choose>
          </td>
          <td>${accomm.accomName}</td>
          <td class="small-text">${accomm.accomAdd}</td>
          <td>${accomm.accomTel}</td>
          <td>${accomm.accomStatus}</td>
          <td>
            <a href="/room/list?accomId=${accomm.accomId}" class="btn-view">객실 보기</a> <!-- ✅ 추가 -->
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</main>