<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ✅ html/head/body 없이 이 안에 내용만 남깁니다 -->

<div style="margin-bottom: 15px;">
    <input type="text" id="accommSearchInput" placeholder="판매자 ID 검색" style="padding: 5px;">
    <button id="accommSearchBtn" class="filter-btn">검색</button>
    <button id="filterPendingBtn" class="filter-btn" data-status="N" type="button">요청 대기 숙소만</button>
    <button id="filterAllBtn" class="filter-btn active" data-status="ALL" type="button">전체 숙소 보기</button>
</div>

<div id="accommTableArea">
    <table>
        <thead>
            <tr>
                <th>숙소 ID</th>
                <th>숙소명</th>
                <th>판매자 ID</th>
                <th>전화번호</th>
                <th>주소</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="acc" items="${accommList}">
                <tr>
                    <td>${acc.accomId}</td>
                    <td>${acc.accomName}</td>
                    <td>${acc.sellerId}</td>
                    <td>${acc.accomTel}</td>
                    <td>${acc.accomAdd}</td>
                    <td>
                        <c:choose>
                            <c:when test="${acc.accomStatus == 'Y'}">승인</c:when>
                            <c:otherwise>요청 대기</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${acc.accomStatus == 'N'}">
                            <button class="approve-btn" data-accomm-id="${acc.accomId}">승인하기</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="pagination" id="accommPagination">
        <c:if test="${blockStart > 1}">
            <a href="javascript:void(0);" class="accomm-page-link" data-page="${blockStart - 1}">« 이전</a>
        </c:if>

        <c:forEach begin="${blockStart}" end="${blockEnd}" var="i">
            <c:choose>
                <c:when test="${i == curPage}">
                    <a href="javascript:void(0);" class="accomm-page-link active" data-page="${i}">${i}</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0);" class="accomm-page-link" data-page="${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${blockEnd < totalPage}">
            <a href="javascript:void(0);" class="accomm-page-link" data-page="${blockEnd + 1}">다음 »</a>
        </c:if>
    </div>
</div>
