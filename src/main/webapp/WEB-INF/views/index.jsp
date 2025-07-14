<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/include/head.jsp" %> <%-- 공통 head --%>

<body class="page">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 GNB --%>
<section class="hero-slider">
  <div class="hero-slide" style="background-image: url('/resources/images/main9.jpg');">
    <div class="hero-content">
      <p class="hero-subtitle">숙소 할인 · 혜택</p>
      <h1 class="hero-title">지금 바로<br>마이트립에서 숙소 예약하세요</h1>
      <p class="hero-desc">MYTRIP 회원 전용, 최대 <strong>20% 할인 쿠폰</strong> 지금 즉시 지급!</p>
      <a href="/event/eventList" class="hero-btn">할인 쿠폰 받기</a>
    </div>
  </div>
    <div class="hero-slide" style="background-image: url('/resources/images/main5.jpg');">
    <div class="hero-content">
      <p class="hero-subtitle">여행 후기</p>
      <h1 class="hero-title">나의 일정을 공유해요</h1>
      <p class="hero-desc">최대 15% 쿠폰 증정</p>
      <a href="/editor/planlist" class="hero-btn">공유된 계획 보기</a>
    </div>
  </div>
  <div class="hero-slide" style="background-image: url('/resources/images/main11.jpg');">
    <div class="hero-content">
      <p class="hero-subtitle">여행 계획</p>
      <h1 class="hero-title">나만의 여행 일정,<br>MYTRIP으로 간편해졌어요</h1>
      <p class="hero-desc">여행을 한눈에, 그리고 한 번에!</p>
      <a href="/schedule/addList" class="hero-btn">계획 만들러가기</a>
    </div>
  </div>
  <div class="hero-slide" style="background-image: url('/resources/images/main4.jpg');">
    <div class="hero-content">
      <p class="hero-subtitle">여행 계획</p>
      <h1 class="hero-title">나만의 여행 일정,<br>MYTRIP으로 간편해졌어요</h1>
      <p class="hero-desc">여행을 한눈에, 그리고 한 번에!</p>
      <a href="/schedule/addList" class="hero-btn">계획 만들러가기</a>
    </div>
  </div>



  <!-- 슬라이드 화살표 -->
  <button class="hero-prev">&#10094;</button>
  <button class="hero-next">&#10095;</button>
</section>



<main id="main" class="wrap">
  <!-- ───────── BEST REVIEW (TOP3) ───────── -->
  <section id="best-review" class="section">
    <h3 class="section-title">BEST · REVIEW</h3>
    <div class="review-grid">
<c:forEach var="r" items="${bestReviewList}" varStatus="i">
  <a href="/editor/planview?planId=${r.planId}" class="review-card-link">
    <article class="review-card">
    ${r.thumbnail}    
      <div class="review-body">
        <h4>${r.planTitle}</h4>
        <span class="user">by ${r.userName}</span>
      </div>
    </article>
  </a>
</c:forEach>
    </div>
  </section>
  <!-- ───────── REGION CARD LIST (17) ───────── -->
  <section id="region" class="section">
    <h3 class="section-title">CITY</h3>
    <div class="region-grid">
    <c:forEach var="r" items="${regionList}">
  <c:set var="regionId" value="${r.regionId}" />
  <c:set var="regionName" value="${r.regionName}" />
  <article class="region-card"
           data-region-id="${regionId}"
           data-region-name="${regionName}">
    <div class="region-thumb"
         style="background-image:url('/resources/region/${regionId}.jpg')">
      <div class="region-label">${regionName}</div>
    </div>
  </article>
</c:forEach>

    </div>
  </section>
</main>

<!-- ───────── REGION DETAIL MODAL ───────── -->
<div id="regionModal" class="modal hidden" role="dialog" aria-modal="true">
<div class="modal-content" style="max-width: 960px; display: flex; gap: 32px; padding: 40px; border-radius: 16px;">
  <button class="close-btn" onclick="closeModal()">×</button>

  <!-- 왼쪽 텍스트 영역 -->
  <div style="flex: 1;">
    <h4 id="modalRegionCode" style="font-size: 14px; color: #999; text-transform: uppercase;">REGION</h4>
    <h2 id="modalTitle" style="font-size: 28px; margin: 8px 0 20px;">지역 이름</h2>
    <p id="modalDesc" style="font-size: 15px; color: #555; line-height: 1.6; margin-bottom: 24px;">설명</p>

    <ul id="modalFacts" style="font-size: 14px; line-height: 1.8; color: #333; list-style: none; padding: 0;">
  <li>이동 시간: <span id="factTime"></span></li>
  <li>추천 시기: <span id="factSeason"></span></li>
  <li>날씨 특징: <span id="factWeather"></span></li>
  <li>대표 음식: <span id="factFood"></span></li>
    </ul>

      <br /><br /><br />
      <div style="margin-top: 24px; display: flex; gap: 12px; justify-content: flex-start">
      <button class="modal-btn" id="hotelBtn">숙소 보기</button>
      <button class="modal-btn" id="tourBtn">관광지 보기</button>
    </div>
          <br />
        <a href="/schedule/addList" class="sche-btn" style="margin-top: 24px; display: inline-block;">여행일정 만들기</a>
    
  </div>

  <!-- 오른쪽 이미지 영역 -->
  <div style="flex: 1;">
    <div id="modalImage" style="width: 100%; aspect-ratio: 3 / 4; background-size: cover; background-position: center; border-radius: 12px;"></div>


  </div>
</div>


<style>
  :root {
    --fg: #111; --bg: #fff; --border: #ebebeb; --radius: 12px;
    --max: 1440px; --gutter: 48px;
  }
  body.page { margin: 0; font-family: 'Noto Sans KR', sans-serif; color: var(--fg); background: var(--bg); }
  h1, h2, h3, h4 { font-family: 'Playfair Display', serif; margin: 0; }
  main.wrap { max-width: var(--max); margin: 0 auto; padding: 0 var(--gutter); }
  .section { padding: 72px 0; }
  .section-title { font-size: 32px; font-weight: 700; margin-bottom: 40px; position: relative; }
  .section-title::after { content: ''; display: block; width: 40px; height: 3px; background: var(--fg); margin-top: 16px; }
.hero-banner {
  position: relative;
  width: 100%;
  height: 85vh;
  background-image: url('/resources/images/main5.jpg'); /* ← 이미지 경로 교체 */
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: flex-start;
}

.hero-banner::after {
  content: "";
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.4); /* 어두운 오버레이 */
}

.hero-content {
  position: relative;
  z-index: 2;
  margin-left: var(--gutter, 80px);
  max-width: 600px;
}

.hero-subtitle {
  font-size: 14px;
  font-weight: 500;
  opacity: 0.8;
  margin-bottom: 12px;
}

.hero-title {
  font-size: 40px;
  font-weight: 700;
  line-height: 1.4;
  margin-bottom: 20px;
}

.hero-desc {
  font-size: 16px;
  color: #eee;
  line-height: 1.6;
  margin-bottom: 30px;
}

.hero-btn {
  display: inline-block;
  padding: 14px 30px;
  border-radius: 999px;
  border: 1.5px solid #fff;
  color: #fff;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.25s ease;
}

.hero-btn:hover {
  background: #fff;
  color: #111;
}



.sche-btn {
  display: inline-block;
  padding: 14px 30px;
  border-radius: 999px;
  border: 1.5px solid #111;  /* #fff → #111 변경 */
  color: #111;      
  font-weight: 600;
  text-decoration: none;
  transition: all 0.25s ease;
}

.sche-btn:hover {
  background: #fff;
  color: #111;
}

.intro-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  height: calc(100vh - 64px); /* 네비게이션이 약 64px이면 이만큼 빼줘야 전체창에 맞음 */
  background: #fff;
  color: #111;
  font-family: 'Noto Sans KR', sans-serif;
}


.intro-card {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 64px;
}

.intro-card.left {
  background: #111;
  color: #fff;
}

.intro-card.right {
  background: #f7f7f7;
  color: #111;
}

.intro-card h4 {
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 12px;
  opacity: 0.8;
}

.intro-card h2 {
  font-size: 32px;
  font-weight: 700;
  margin-bottom: 20px;
  line-height: 1.5;
}

.intro-card p {
  font-size: 15px;
  line-height: 1.6;
  margin-bottom: 32px;
  opacity: 0.9;
}

.intro-btn {
  display: inline-block;
  font-size: 15px;
  font-weight: 600;
  padding: 12px 24px;
  border-radius: 999px;
  text-decoration: none;
  background: #fff;
  color: #111;
  border: none;
  transition: 0.2s ease;
}

.intro-btn:hover {
  background: #eee;
}

.intro-btn.outline {
  background: transparent;
  border: 1px solid #111;
  color: #111;
}

.intro-btn.outline:hover {
  background: #111;
  color: #fff;
}
.schedule-preview {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 64px;
  padding: 100px var(--gutter);
  background: #fff;
  color: #111;
  max-width: 1440px;
  margin: 0 auto;
}

.preview-left {
  flex: 1;
}

.preview-left h5 {
  font-size: 14px;
  color: #0072ff;
  font-weight: 600;
  margin-bottom: 12px;
}

.preview-left h2 {
  font-size: 32px;
  font-weight: 700;
  line-height: 1.5;
  margin-bottom: 20px;
}

.preview-left p {
  font-size: 15px;
  color: #444;
  margin-bottom: 32px;
  line-height: 1.6;
}

.preview-course-list {
  list-style: none;
  padding: 0;
  margin: 0 0 32px;
}

.preview-course-list li {
  font-size: 14px;
  margin: 6px 0;
  display: flex;
  align-items: center;
  color: #555;
}

.preview-course-list li span {
  display: inline-block;
  background: #111;
  color: #fff;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  text-align: center;
  font-size: 13px;
  margin-right: 10px;
  line-height: 22px;
  font-weight: 500;
}

.preview-btn {
  display: inline-block;
  background: #111;
  color: #fff;
  font-size: 14px;
  font-weight: 600;
  padding: 12px 24px;
  border-radius: 999px;
  text-decoration: none;
  transition: background 0.2s ease;
}

.preview-btn:hover {
  background: #333;
}

.preview-right {
  flex: 1;
  display: flex;
  justify-content: center;
}

.preview-right img {
  max-width: 100%;
  border-radius: 16px;
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
}

  .hero { height: 60vh; background: #000 url('/resources/images/main_1.jpg') center/cover;
          color: #fff; display: flex; align-items: center; justify-content: center; }
  .hero h2 { font-size: 48px; font-weight: 700; color: #fff; text-align: center; }

  .review-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 32px; }
  .review-card { border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; background: #fff; }
  .review-card img { width: 100%; aspect-ratio: 4/3; object-fit: cover; display: block; }
  .review-body { padding: 24px; }
  .review-body h4 { font-size: 20px; margin-bottom: 12px; }
  .user { display: block; margin-top: 18px; font-size: 14px; color: #666; }

  .region-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 28px; }
  .region-card { cursor: pointer; border: 1px solid var(--border); border-radius: var(--radius);
                 transition: transform .25s ease; background: #fff; text-align: center; }
  .region-card:hover { transform: translateY(-6px); }
.region-thumb {
  position: relative;
  width: 100%;
  aspect-ratio: 3 / 4;
  background-size: cover;
  background-position: center;
  border-radius: var(--radius); /* ← 전체를 둥글게 */
  overflow: hidden;
}

.region-label {
  position: absolute;
  bottom: 12px;
  left: 12px;
 color: rgba(255, 255, 255, 0.85); /* ← 반투명한 흰색 텍스트 */
  padding: 6px 12px;
  font-size: 22px;
  font-weight:500;   /* ← 600 → 400 으로 변경 */
  border-radius: 8px;
}
  .region-card h4 { padding: 18px 0; font-size: 18px; }

  .modal { position: fixed; inset: 0; background: rgba(0,0,0,.5);
           display: flex; align-items: center; justify-content: center; z-index: 999; }
  .modal.hidden { display: none; }
  .close-btn { position: absolute; top: 12px; right: 14px; background: none; border: none; font-size: 28px; cursor: pointer; }

  .modal-content {
  background: #fff;
  box-shadow: 0 12px 24px rgba(0,0,0,0.15);
    max-height: 70vh;  /* 화면 높이의 70%로 제한 */
  overflow-y: auto;  /* 내용이 넘치면 스크롤 */
}

.modal-btn {
  padding: 12px 20px;
  border: 1px solid #ccc;
  border-radius: 999px;
  background: #f9f9f9;
  cursor: pointer;
  font-weight: 500;
  font-size: 14px;
}

.modal-btn:hover {
  background: #333;
  color: #fff;
  border-color: #333;
}
  
  body.blurred #main { filter: blur(4px); pointer-events: none; user-select: none; }
  #regionModal .region-thumb { width: 100%; aspect-ratio: 3 / 4; background-size: cover; background-position: center;}
            .hero-slider {
  position: relative;
  width: 100%;
  height: 85vh;
  overflow: hidden;
}

.hero-slide {
  position: absolute;
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
  opacity: 0;
  transition: opacity 0.8s ease-in-out;
}

.hero-slide.active {
  opacity: 1;
  z-index: 2;
}

.hero-content {
  position: absolute;
  z-index: 3;
  left: var(--gutter, 80px);
  top: 50%;
  transform: translateY(-50%);
  color: #fff;
  max-width: 600px;
}

/* 기존 .hero-subtitle, .hero-title, .hero-desc, .hero-btn 그대로 유지 */

.hero-prev,
.hero-next {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(0, 0, 0, 0.4);
  color: white;
  font-size: 28px;
  padding: 12px;
  cursor: pointer;
  z-index: 4;
  border: none;
  border-radius: 50%;
}

.hero-prev { left: 20px; }
.hero-next { right: 20px; }

.hero-prev:hover, .hero-next:hover {
  background: rgba(0, 0, 0, 0.6);
}
                               border-radius: var(--radius); border: 1px solid var(--border); }
</style>

<script>
  const modal      = document.getElementById('regionModal');
  const regionDescriptions = {
		  "서울": "정치, 경제, 문화의 중심지로서 역사 유적과 현대적 랜드마크가 공존합니다. 경복궁, 남산타워, 한강 등 도심 속 명소가 풍부하며 쇼핑과 맛집 투어에도 최적입니다. 계절별 축제와 다양한 테마파크도 인기입니다.",
		  "인천": "공항과 항구가 있는 교통 요충지로 개항장과 차이나타운이 유명합니다. 송도 신도시의 현대적 풍경과 월미도·강화도 등 자연 명소도 가볼 만합니다. 바다를 낀 해산물 음식도 즐길 수 있습니다.",
		  "대전": "과학과 교육 중심 도시로 대덕연구단지와 엑스포과학공원이 유명합니다. 계족산 황토길, 유성온천 등 힐링 코스도 많으며, 중부 내륙 여행의 거점 역할을 합니다. 대전역 근처 먹거리도 풍부합니다.",
		  "대구": "뜨거운 여름으로 유명한 내륙 도시로 팔공산과 근대골목 등이 관광명소입니다. 전통시장과 대구 패션거리, 야경 명소도 인기입니다. 매운 음식 문화와 따로국밥 같은 지역 먹거리도 빼놓을 수 없습니다.",
		  "광주": "예술과 민주화의 도시로 국립아시아문화전당과 5.18 관련 유적지가 있습니다. 무등산을 중심으로 한 자연 경관과 맛깔스러운 남도 음식이 매력입니다. 전통과 현대가 어우러진 문화도시입니다.",
		  "부산": "대한민국 제2의 도시이자 대표적인 해양 관광도시입니다. 해운대, 광안리 해변과 자갈치시장, 감천문화마을 등 볼거리가 풍부합니다. 해산물과 길거리 음식도 부산 여행의 큰 즐거움입니다.",
		  "울산": "산업도시의 이미지 외에도 대왕암공원, 간절곶 등 자연경관이 인상적입니다. 고래문화특구로 유명하며, 울산 12경을 따라 즐기는 드라이브도 추천됩니다. 조용한 힐링 여행지로도 적합합니다.",
		  "세종특별자치시": "행정 중심 복합도시로 계획도시답게 쾌적하고 조용한 분위기입니다. 호수공원과 중앙녹지축 등 녹지가 많아 산책이나 자전거 타기에도 좋습니다. 가족 단위 여행자에게 적합한 도시입니다.",
		  "경기도": "서울을 둘러싼 수도권 지역으로 다양한 테마파크와 자연휴양지가 공존합니다. 남양주, 파주, 가평, 용인 등 테마별 여행지가 분포해 있습니다. 당일치기 또는 1박 2일 소풍지로 제격입니다.",
		  "강원특별자치도": "동해안과 산악지형이 어우러진 자연 관광지의 보고입니다. 강릉, 속초, 평창 등에서 바다·산·계곡을 모두 즐길 수 있습니다. 사계절 내내 액티비티와 자연경관을 동시에 누릴 수 있습니다.",
		  "충청북도": "내륙 깊숙이 위치한 자연친화적 지역으로 충주호, 월악산 등이 유명합니다. 조용하고 평화로운 분위기로 힐링 여행에 제격입니다. 청주·충주를 중심으로 문화재도 다양합니다.",
		  "충청남도": "서해안 해변과 논산, 공주 등 전통 역사도시가 어우러진 지역입니다. 백제 문화유산이 많고 온천, 유채꽃 명소 등 가족여행지로도 좋습니다. 수도권과 가까워 주말 여행지로 인기입니다.",
		  "경상북도": "신라 천년의 수도 경주를 비롯해 전통문화유산이 풍부한 지역입니다. 안동, 문경 등 한옥과 전통 음식이 살아 있는 곳도 많습니다. 조용한 분위기 속 전통과 자연을 함께 누릴 수 있습니다.",
		  "경상남도": "남해안과 지리산을 품은 지역으로 바다와 산이 모두 매력적인 곳입니다. 진주, 통영, 남해 등 관광도시가 많고 먹거리도 풍부합니다. 봄 벚꽃과 가을 단풍 시즌엔 더욱 아름답습니다.",
		  "전북특별자치도": "전주 한옥마을과 비빔밥으로 유명한 전통문화의 중심지입니다. 남원, 무주, 고창 등 다양한 문화유산과 자연이 조화롭습니다. 음식이 맛있고 여유로운 분위기의 여행지입니다.",
		  "전라남도": "남도 특유의 정겨움과 음식문화가 살아 있는 지역입니다. 여수, 순천, 담양, 보성 등 자연과 문화가 공존하는 명소가 많습니다. 해안 드라이브와 섬 여행도 즐길 수 있습니다.",
		  "제주도": "한국을 대표하는 휴양지로 자연경관과 문화유산이 뛰어납니다. 한라산, 협재해변, 우도 등 다채로운 볼거리를 자랑합니다. 사계절 모두 매력적이며 음식도 독특한 편입니다."
		};

  const regionDetails = {
		  "서울": {
			    code: "SEOUL",
			    time: "지하철·버스 등으로 1시간 이내 접근 가능",
			    season: "봄, 가을 (벚꽃·단풍 시즌)",
			    weather: "사계절 뚜렷, 대체로 온화",
			    food: "평양냉면, 국밥, 떡볶이 등"
			  },
			  "인천": {
			    code: "INCHEON",
			    time: "서울에서 지하철 또는 공항철도 1시간",
			    season: "봄, 가을 추천",
			    weather: "서해안 특유의 바람과 기온차 있음",
			    food: "신포닭강정, 짜장면 원조거리"
			  },
			  "대전": {
			    code: "DAEJEON",
			    time: "KTX 약 50분, 고속도로로 2시간 내외",
			    season: "가을 대청호 단풍 명소",
			    weather: "내륙성 기후, 여름 덥고 겨울 추움",
			    food: "성심당 빵, 칼국수"
			  },
			  "대구": {
			    code: "DAEGU",
			    time: "KTX 약 1시간 50분",
			    season: "봄 벚꽃, 가을 단풍 인기",
			    weather: "여름 매우 더움으로 주의",
			    food: "막창, 따로국밥"
			  },
			  "광주": {
			    code: "GWANGJU",
			    time: "KTX 약 2시간",
			    season: "가을 무등산 등산 추천",
			    weather: "따뜻한 남부 지방 기후",
			    food: "광주 떡갈비, 한정식"
			  },
			  "부산": {
			    code: "BUSAN",
			    time: "KTX 약 2시간 30분",
			    season: "여름 해운대, 겨울 온천 인기",
			    weather: "겨울 온화, 여름 습함",
			    food: "돼지국밥, 밀면, 씨앗호떡"
			  },
			  "울산": {
			    code: "ULSAN",
			    time: "부산에서 30~40분",
			    season: "가을 울산대공원 단풍 명소",
			    weather: "해안과 내륙 모두 포함, 기온 차 있음",
			    food: "울산불고기, 고래고기"
			  },
			  "세종특별자치시": {
			    code: "SEJONG",
			    time: "대전과 인접, 자차로 30분 내외",
			    season: "봄과 가을 공원 산책에 적합",
			    weather: "내륙성 기후, 뚜렷한 사계절",
			    food: "세종 로컬 농산물 기반 식당 많음"
			  },
			  "경기도": {
			    code: "GYEONGGI",
			    time: "서울 인접, 전철 또는 자차 1~2시간",
			    season: "계절 상관없이 인기",
			    weather: "지역마다 다름 (북부/남부)",
			    food: "수원갈비, 이천쌀밥"
			  },
			  "강원특별자치도": {
			    code: "GANGWON",
			    time: "서울 → 강릉 KTX 1시간 40분",
			    season: "겨울 스키장, 여름 동해바다",
			    weather: "산간 지역 눈 많음",
			    food: "황태구이, 감자전, 막국수"
			  },
			  "충청북도": {
			    code: "CHUNGBUK",
			    time: "서울 → 청주 자차 2시간",
			    season: "가을 충주호 단풍",
			    weather: "내륙성, 일교차 큼",
			    food: "올갱이국, 청국장"
			  },
			  "충청남도": {
			    code: "CHUNGNAM",
			    time: "서울 → 천안 KTX 1시간",
			    season: "봄 개나리길·가을 유채꽃",
			    weather: "평야 지역, 온화한 기후",
			    food: "호두과자, 천안순대"
			  },
			  "경상북도": {
			    code: "GYEONGBUK",
			    time: "서울 → 안동 KTX 약 2시간",
			    season: "가을 하회마을, 전통마을 관광",
			    weather: "내륙 기후",
			    food: "안동찜닭, 헛제삿밥"
			  },
			  "경상남도": {
			    code: "GYEONGNAM",
			    time: "부산 인접, 마산·진주 KTX 있음",
			    season: "봄 벚꽃길, 가을 국화축제",
			    weather: "남부 따뜻한 기후",
			    food: "진주냉면, 마산아귀찜"
			  },
			  "전북특별자치도": {
			    code: "JEONBUK",
			    time: "서울 → 전주 고속버스 2시간 30분",
			    season: "봄 한옥마을, 가을 단풍터널",
			    weather: "전형적인 평야성 기후",
			    food: "전주비빔밥, 한정식"
			  },
			  "전라남도": {
			    code: "JEONNAM",
			    time: "서울 → 여수 KTX 약 3시간",
			    season: "여름 남해안 해변, 봄 녹차밭",
			    weather: "따뜻한 남부 기후",
			    food: "꼬막비빔밥, 남도 백반"
			  },
			  "제주도": {
			    code: "JEJU",
			    time: "김포 → 제주 약 1시간 비행",
			    season: "4계절 내내 인기, 특히 봄·가을",
			    weather: "해양성 기후, 바람 많음",
			    food: "흑돼지, 고기국수, 갈치조림"
			  }
			  };
  const modalTitle = document.getElementById('modalTitle');
  const modalImage = document.getElementById('modalImage');
  const hotelBtn   = document.getElementById('hotelBtn');
  const tourBtn    = document.getElementById('tourBtn');

  document.addEventListener('DOMContentLoaded', () => {
    // 모든 지역 카드 정보 출력 (디버깅용)
    console.log("🔍 모든 지역 카드 정보:");
    document.querySelectorAll('.region-card').forEach((card, index) => {
      const regionId = card.getAttribute('data-region-id');
      const regionName = card.getAttribute('data-region-name');
      console.log(`${index + 1}. regionId: ${regionId}, regionName: ${regionName}`);
    });

    document.querySelectorAll('.region-card').forEach(card => {
      card.addEventListener('click', function(event) {
        // 이벤트 전파 중단
        event.stopPropagation();
        
        // 모든 가능한 방법으로 regionId 확인
        const method1 = this.getAttribute('data-region-id');
        const method2 = event.currentTarget.getAttribute('data-region-id');
        const method3 = this.dataset.regionId;
        const method4 = event.currentTarget.dataset.regionId;
        
        console.log("🔍 regionId 확인:");
        console.log("  method1 (this.getAttribute):", method1, typeof method1);
        console.log("  method2 (event.currentTarget.getAttribute):", method2, typeof method2);
        console.log("  method3 (this.dataset):", method3, typeof method3);
        console.log("  method4 (event.currentTarget.dataset):", method4, typeof method4);
        
        const regionId = method1 || method2 || method3 || method4;
        const regionName = this.getAttribute('data-region-name');
        
        console.log("✅ 최종 선택된 regionId:", regionId, ", 타입:", typeof regionId);
        console.log("✅ 최종 선택된 regionName:", regionName);
        console.log("🎯 클릭된 엘리먼트:", this);
        
        // 즉시 showModal 호출 (변수 참조 문제 방지)
        showModal(regionId, regionName);
      });
    });
  });

  function showModal(regionId, regionName) {
    console.log("🧪 showModal 진입: regionId =", regionId, ", regionName =", regionName);
    console.log("🔍 regionId 타입:", typeof regionId, ", 값:", regionId);
    console.log("🔍 regionId 길이:", regionId ? regionId.length : 'null/undefined');

    if (!regionId || regionId === '' || regionId === 'undefined' || regionId === 'null') {
      console.warn("❌ regionId 값이 유효하지 않습니다:", regionId);
      return;
    }

    // regionId를 안전하게 처리
    const safeRegionId = regionId.toString().trim();
    console.log("🔒 안전한 regionId:", safeRegionId, ", 길이:", safeRegionId.length);

    if (!safeRegionId || safeRegionId === '') {
      console.warn("❌ 처리된 regionId가 빈 문자열입니다.");
      return;
    }

    modalTitle.textContent = regionName;
    const details = regionDetails[regionName] || {};
    document.getElementById('modalRegionCode').textContent = details.code || regionName.toUpperCase();
    document.getElementById('factTime').textContent = details.time || '-';
    document.getElementById('factSeason').textContent = details.season || '-';
    document.getElementById('factWeather').textContent = details.weather || '-';
    document.getElementById('factFood').textContent = details.food || '-';
    
    const desc = regionDescriptions[regionName] || "이 지역에 대한 설명이 아직 등록되지 않았습니다.";
    document.getElementById('modalDesc').innerText = desc;
    const imgUrl = "/resources/region/" + safeRegionId + ".jpg";
    console.log("🖼️ 이미지 URL 설정:", imgUrl);
    console.log("🔍 URL 구성 요소 확인:");
    console.log("  베이스 경로: /resources/region/");
    console.log("  regionId: '" + safeRegionId + "'");
    console.log("  확장자: .jpg");
    console.log("  최종 URL: " + imgUrl);
    
    // 이미지 로딩 확인
    const testImg = new Image();
    testImg.onload = function() {
      console.log("✅ 이미지 로딩 성공:", imgUrl);
      modalImage.style.backgroundImage = "url('" + imgUrl + "')";
    };
    testImg.onerror = function() {
      console.error("❌ 이미지 로딩 실패:", imgUrl);
      // 기본 이미지 또는 플레이스홀더로 대체
      modalImage.style.backgroundImage = 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
      modalImage.style.backgroundColor = '#f0f0f0';
      // 텍스트로 지역명 표시
      modalImage.innerHTML = `<div style="display: flex; align-items: center; justify-content: center; height: 100%; color: white; font-size: 18px; font-weight: bold;">${regionName}</div>`;
    };
    testImg.src = imgUrl;

    // 버튼 클릭 이벤트 설정
    hotelBtn.onclick = () => {
      console.log("🏨 숙소 보기 클릭 - regionId:", safeRegionId);
      location.href = "/accomm/list?regionId=" + regionId;
    };
    tourBtn.onclick = () => {
      console.log("🗺️ 관광지 보기 클릭 - regionId:", safeRegionId);
      location.href = "/tour/list?regionId=" + regionId;
    };

    // 모달 표시
    document.body.classList.add('blurred');
    modal.classList.remove('hidden');
  }

  function closeModal() {
    document.body.classList.remove('blurred');
    modal.classList.add('hidden');
  }

  document.addEventListener('keydown', e => {
    if (e.key === 'Escape' && !modal.classList.contains('hidden')) {
      closeModal();
    }
  });

  // 모달 배경 클릭 시 닫기
  modal.addEventListener('click', (e) => {
    if (e.target === modal) {
      closeModal();
    }
  });
  document.addEventListener('DOMContentLoaded', () => {
    const slides = document.querySelectorAll('.hero-slide');
    const prevBtn = document.querySelector('.hero-prev');
    const nextBtn = document.querySelector('.hero-next');
    let current = 0;

    function showSlide(index) {
      slides.forEach((slide, i) => {
        slide.classList.remove('active');
        if (i === index) slide.classList.add('active');
      });
    }

    function nextSlide() {
      current = (current + 1) % slides.length;
      showSlide(current);
    }

    function prevSlide() {
      current = (current - 1 + slides.length) % slides.length;
      showSlide(current);
    }

    nextBtn.addEventListener('click', nextSlide);
    prevBtn.addEventListener('click', prevSlide);

    // 자동 슬라이드
    setInterval(nextSlide, 5000); // 5초마다 자동 전환

    // 초기 상태
    showSlide(current);
  });


</script>
</body>
</html>