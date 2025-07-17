<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 관리</title>
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
        .filter-btn, select {
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
    <input type="text" id="reviewSearchInput_rev" value="${keyword}" placeholder="작성자 ID 검색" style="padding:5px;">
    <button id="reviewSearchBtn_rev" type="button" class="filter-btn">검색</button>

	

    <!-- ✅ 정렬 셀렉트 박스 -->
    <select id="reviewOrderSelect_rev">
        <option value="recent" ${order == 'recent' ? 'selected' : ''}>최신순</option>
        <option value="report" ${order == 'report' ? 'selected' : ''}>신고량순</option>
        <option value="view" ${order == 'view' ? 'selected' : ''}>조회순</option>
    </select>

    <!-- ✅ 상태 필터 버튼 추가 -->
    <button id="filterPublicReviewBtn" class="filter-btn ${empty status or status == 'Y' ? 'active' : ''}" data-status="Y">공개 리뷰만</button>
    <button id="filterPrivateReviewBtn" class="filter-btn ${status == 'N' ? 'active' : ''}" data-status="N">비공개 리뷰만</button>
</div>

<div id="reviewTableArea">
    <table>
        <thead>
            <tr>
                <th>리뷰 ID</th>
                <th>숙소명</th>
                <th>작성자 ID</th>
                <th>조회수</th>
                <th>신고수</th>
                <th>등록일</th>
                <th>상태</th>
				<th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="review" items="${reviewList}">
                <tr>
                    <td>${review.planId}</td>
                    <td>${review.planTitle}</td>
                    <td>${review.userId}</td>
                    <td>${review.planCount}</td>
                    <td>${review.planReport}</td>
                    <td>${review.planRegdate}</td>
                    <td>
            <c:choose>
                <c:when test="${review.planStatus == 'Y'}">공개</c:when>
                <c:otherwise>비공개</c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:if test="${review.planStatus == 'Y'}">
                <button class="review-hide-btn" data-plan-id="${review.planId}">비공개 처리</button>
            </c:if>
        </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="pagination" id="reviewPagination">
        <!-- ◀ 이전 블록 -->
        <c:if test="${blockStart > 1}">
            <a href="javascript:void(0);" class="review-page-link" data-page="${blockStart - 1}">« 이전</a>
        </c:if>

        <!-- 📄 현재 블록 페이지 번호 출력 -->
        <c:forEach begin="${blockStart}" end="${blockEnd}" var="i">
            <c:choose>
                <c:when test="${i == curPage}">
                    <a href="javascript:void(0);" class="review-page-link active" data-page="${i}">${i}</a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:void(0);" class="review-page-link" data-page="${i}">${i}</a>
                </c:otherwise> 
            </c:choose>
        </c:forEach>
 
        <!-- ▶ 다음 블록 -->
        <c:if test="${blockEnd < totalPage}">
            <a href="javascript:void(0);" class="review-page-link" data-page="${blockEnd + 1}">다음 »</a>
        </c:if>
    </div>
</div>
</body>
</html>
