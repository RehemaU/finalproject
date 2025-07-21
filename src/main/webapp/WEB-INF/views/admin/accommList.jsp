<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>숙소 관리</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .approve-btn {
            background-color: #1ab394;
            color: white;
            padding: 6px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .filter-btn {
            padding: 6px 10px;
            margin-left: 5px;
            cursor: pointer;
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
</head>
<body>
<div style="margin-bottom: 15px;">
    <!-- 고유 ID 부여 -->
    <input type="text" id="accommSearchInput_acc" value="${keyword}" placeholder="판매자 ID 검색" style="padding:5px;">

    <!-- 고유 ID 부여 + type="button" -->
    <button id="accommSearchBtn_acc" type="button" class="filter-btn">검색</button>
    <button id="filterPendingBtn" class="filter-btn ${status == 'N' ? 'active' : ''}" data-status="N">요청 대기 숙소만</button>
	<button id="filterAllBtn" class="filter-btn ${empty status ? 'active' : ''}" data-status="">전체 숙소 보기</button>

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

    <!-- ◀ 이전 블록 -->
    <c:if test="${blockStart > 1}">
        <a href="javascript:void(0);" class="accomm-page-link" data-page="${blockStart - 1}">« 이전</a>
    </c:if>

    <!-- 📄 현재 블록 페이지 번호 출력 -->
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

    <!-- ▶ 다음 블록 -->
    <c:if test="${blockEnd < totalPage}">
        <a href="javascript:void(0);" class="accomm-page-link" data-page="${blockEnd + 1}">다음 »</a>
    </c:if>

</div>
</div>
</body>
</html>