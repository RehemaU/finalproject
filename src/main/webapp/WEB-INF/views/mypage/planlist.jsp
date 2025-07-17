<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내가 쓴 게시글</title>
    <%-- 필요한 CDN 링크 추가 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <%-- 카드 스타일에 필요한 CSS --%>
    <style>
      .card-img-container img {
        width: 100%;
        height: 200px;
        object-fit: cover;
      }
      .card-text {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
      }
      .user-thumbnail {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        object-fit: cover;
        border: 1px solid #ccc;
      }
    </style>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>

<div class="container py-5">
    <h2 class="text-center mb-4">내가 쓴 게시글</h2>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">

        <c:choose>
            <c:when test="${not empty list}">
                <c:forEach var="editor" items="${list}">
                    <div class="col">
                        <div class="card h-100 shadow-sm">

                            <a href="/editor/planview?planId=${editor.planId}" class="card-img-container d-block">
                                <c:choose>
                                    <c:when test="${not empty editor.thumbnail}">
                                        <c:out value="${editor.thumbnail}" escapeXml="false"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/resources/editorupload/noimg.gif"
                                             alt="이미지 없음"/>
                                    </c:otherwise>
                                </c:choose>
                            </a>

                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title mb-2">
                                    <a href="/editor/planview?planId=${editor.planId}"
                                       class="text-dark text-decoration-none">
                                        ${editor.planTitle}
                                    </a>
                                </h5>

                                <p class="card-text text-muted small mb-2">
                                    작성일: ${editor.planRegdate}
                                </p>

                                <div class="d-flex align-items-center mt-auto">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${editor.userId}.${editor.userImgEx}"
                                         class="user-thumbnail"
                                         alt="작성자 썸네일"/>
                                    <span class="ms-2">${editor.userName}</span>
                                    <span class="ms-auto text-muted small">
                                        <i class="far fa-comment"></i> ${editor.comCount}&nbsp;&nbsp;
                                        <i class="fas fa-heart"></i> ${editor.planRecommend}
                                        <i class="fas fa-eye ms-2"></i> ${editor.planCount}
                                    </span>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    <div class="alert alert-secondary text-center mb-0">
                        작성한 게시글이 없습니다.
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>