<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 날씨 정보</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/weather-icons/2.0.10/css/weather-icons.min.css"/>
    <style>
    /* 전체적인 디자인을 아래 CSS 코드로 교체해주세요 */
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #ffffff; /* 요청하신 흰색 배경 */
        margin: 0;
        /* body에서 padding을 제거하여 내비게이션 바가 화면 전체 너비를 차지하도록 합니다. */
    }

    /* 콘텐츠를 감싸고 중앙 정렬을 위한 컨테이너 */
    .main-container {
        max-width: 1320px; /* 콘텐츠의 최대 너비 설정 */
        margin: 0 auto;    /* 컨테이너를 수평 중앙에 배치 */
        padding: 40px 20px;  /* 상하, 좌우 여백 설정 */
    }

    .weather-grid-container {
        display: grid;
        /* 화면 크기에 따라 1~4개의 카드를 유연하게 표시 */
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 25px;
    }

    .weather-frame {
        /* 테두리를 좀 더 부드럽게 변경 */
        border: 1px solid #e9ecef;
        border-radius: 8px; /* 모서리를 둥글게 처리 */
        background-color: #ffffff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.05); /* 그림자 효과를 약간 더 부드럽게 */
        transition: transform 0.2s, box-shadow 0.2s;
        display: flex;
        flex-direction: column;
        overflow: hidden; /* 둥근 모서리 밖으로 이미지가 나가지 않도록 설정 */
    }

    .weather-frame:hover {
        transform: translateY(-5px); /* 위로 살짝 떠오르는 효과 */
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    }

    .weather-frame img {
        width: 100%;
        height: 250px;
        object-fit: cover;
    }

    .info-bar {
        padding: 15px;
        border-top: 1px solid #e9ecef;
        background-color: #fafafa;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .info-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    .city-name {
        font-weight: bold;
        font-size: 1.2em;
    }

    .temperature {
        font-size: 1.1em;
        font-weight: 500;
        color: #d9534f;
    }

    .weather-details {
        display: flex;
        justify-content: space-around;
        align-items: center;
        text-align: center;
        padding-top: 15px;
        border-top: 1px dashed #ced4da;
    }

    .weather-details > div {
        flex: 1;
    }

    .weather-details i {
        font-size: 1.6rem;
        display: block;
        margin-bottom: 8px;
    }

    /* 흐림 아이콘 색상 수정 (style 태그의 color: 중복 오류 수정) */
    .bi-cloud {
        color: #adb5bd;
    }
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>

<%-- ▼▼▼ 이 컨테이너를 추가해주세요 ▼▼▼ --%>
<div class="main-container">

    <h1 style="text-align:center; margin-bottom: 40px;">지역별 날씨 정보</h1>
	<h5 style="text-align: right; margin-bottom: 40px;"> 기준 시각: ${weatherList[0].baseDate.substring(0,4)}년 ${weatherList[0].baseDate.substring(4,6)}월 ${weatherList[0].baseDate.substring(6,8)}일 / ${weatherList[0].baseTime.substring(0,2)}시 </h5>
    <div class="weather-grid-container">
        <c:forEach var="weather" items="${weatherList}">
            <div class="weather-frame">
                <img src="/resources/regionimg/${weather.city}.jpg" alt="${weather.city}.jpg">
                
                <div class="info-bar">
                    <div class="info-header">
                        <span class="city-name">${weather.city}</span>
                        <span class="temperature">${weather.temperature}°C</span>
                    </div>

                    <div class="weather-details">
                        <div>
                            <c:choose>
                                <c:when test="${weather.skyDescription eq '맑음'}">
                                    <i class="bi bi-sun" style="color: orange;"></i>
                                </c:when>
                                <c:when test="${weather.skyDescription eq '구름 많음'}">
                                    <i class="wi wi-cloudy" style="color: gray;"></i>
                                </c:when>
                                <c:when test="${weather.skyDescription eq '흐림'}">
                                    <i class="bi bi-cloud" style="color: #868e96;"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-question-circle"></i>
                                </c:otherwise>
                            </c:choose>
                            <span>${weather.skyDescription}</span>
                        </div>

                        <div>
                            <c:choose>
                                <c:when test="${weather.rainDescription eq '비소식 없음'}">
                                    <i class="bi bi-droplet" style="color: #CCE5FF;"></i>
                                </c:when>
                                <c:when test="${weather.rainDescription eq '비'}">
                                    <i class="bi bi-cloud-rain" style="color: #6495ED;"></i>
                                </c:when>
                                <c:when test="${weather.rainDescription eq '비/눈'}">
                                    <i class="wi wi-rain-mix" style="color: #6AAEE1;"></i>
                                </c:when>
                                <c:when test="${weather.rainDescription eq '눈'}">
                                    <i class="wi wi-snow" style="color: #70c8d6;"></i>
                                </c:when>
                                <c:when test="${weather.rainDescription eq '소나기'}">
                                    <i class="wi wi-showers" style="color: #274472;"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-question-circle"></i>
                                </c:otherwise>
                            </c:choose>
                            <span>${weather.rainDescription}</span>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

</div> <%-- ▲▲▲ 여기서 컨테이너를 닫아주세요 ▲▲▲ --%>

</body>
</html>