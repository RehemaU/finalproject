<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>

  <title>MYTRIP – Walkthrough · Explore · Stay · Plan · Share</title>

<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
  <main class="wrap">
    <!-- ========== INTRO GRID ========== -->
    <section class="grid">
      <div class="hero"><h2></h2></div>

      <article class="card">
        <div class="card-img"></div>
        <div class="card-body">
          <h3>여행 계획을 세우기 좋은 요즘</h3>
          <p>지역별 추천 스팟과 숙소를 한눈에 확인해보세요.</p>
        </div>
      </article>
<nav class="navbar navbar-expand-sm bg-secondary navbar-dark mb-3"> 
	<ul class="navbar-nav"> 
	    <!-- ✅ 쿠폰 발급 테스트용 메뉴 추가 -->
	    <li class="nav-item">
	      <a class="nav-link" href="/event/coupontest">쿠폰 발급</a> 
	    </li>
  </ul> 
</nav>

      <div class="stack">
        <article class="card">
          <div class="card-img"></div>
          <div class="card-body">
            <h3>마이페이지에서 내 여행기록 확인</h3>
            <p>내가 찜한 장소, 예약 내역, 후기를 쉽게 관리해보세요.</p>
          </div>
        </article>
        <article class="card">
          <div class="card-img"></div>
          <div class="card-body">
            <h3>여행의 추억을 공유해보세요</h3>
            <p>작성한 일정을 바탕으로 후기를 남기고 다른 사람과 공유해요.</p>
          </div>
        </article>
      </div>
    </section>

<div class="container">

    <!-- ========== HOT TOUR ========== -->
    <h3 class="section-title">HOT · TOUR</h3>
    <div class="mix-grid">
      <a class="tile large">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1000&q=80')"></div>
        <div class="info"><h4>에메랄드 해변</h4><span>GUAM</span></div>
      </a>
      <a class="tile">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1569931725250-b937da0bfb0c?auto=format&fit=crop&w=800&q=80')"></div>
        <div class="info"><h4>몽마르트 언덕</h4><span>PARIS</span></div>
      </a>
      <a class="tile">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1486025402772-bc179c8dfdaf?auto=format&fit=crop&w=800&q=80')"></div>
        <div class="info"><h4>카우아이 협곡</h4><span>HAWAII</span></div>
      </a>
      <a class="tile">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1519822477402-7847d08eccee?auto=format&fit=crop&w=800&q=80')"></div>
        <div class="info"><h4>사파리 사막</h4><span>DUBAI</span></div>
      </a>
    </div>

    <!-- ========== HOT HOTEL ========== -->
    <h3 class="section-title">HOT · HOTEL</h3>
    <div class="mix-grid">
      <a class="tile large">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1000&q=80')"></div>
        <div class="info"><h4>라구나 리조트</h4><span>$180 /night</span></div>
      </a>
      <a class="tile">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1590490357155-3054ef779c92?auto=format&fit=crop&w=800&q=80')"></div>
        <div class="info"><h4>오션 빌라</h4><span>$240 /night</span></div>
      </a>
      <a class="tile">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1542317830-f5200e80b0fa?auto=format&fit=crop&w=800&q=80')"></div>
        <div class="info"><h4>포레스트 롯지</h4><span>$150 /night</span></div>
      </a>
      <a class="tile">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80')"></div>
        <div class="info"><h4>아틀라스 호텔</h4><span>$210 /night</span></div>
      </a>
    </div>
<<<<<<< HEAD
  </article>
</c:forEach>

    </div>
  </section>
</main>

<!-- ───────── REGION DETAIL MODAL ───────── -->
<div id="regionModal" class="modal hidden" role="dialog" aria-modal="true">
  <div class="modal-content">
    <button class="close-btn" onclick="closeModal()">×</button>
    <div id="modalImage" class="region-thumb" style="margin-bottom: 24px;"></div>
    <h3 id="modalTitle"></h3>
    <p id="modalDesc" style="margin-top: 12px; font-size: 15px; color: #555;"></p>
    
    <div class="btn-wrap">
      <button id="hotelBtn" class="modal-btn">숙소 보기</button>
      <button id="tourBtn" class="modal-btn">관광지 보기</button>
    </div>
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
  .modal-content { background: #fff; width: 320px; padding: 40px 32px; border-radius: var(--radius); text-align: center; position: relative; }
  .close-btn { position: absolute; top: 12px; right: 14px; background: none; border: none; font-size: 28px; cursor: pointer; }
  .modal-btn { display: block; width: 100%; margin: 16px 0; padding: 14px 0; border: 1px solid var(--fg);
               border-radius: var(--radius); background: #fff; font-size: 16px; font-weight: 600; cursor: pointer; }
  .modal-btn:hover { background: var(--fg); color: #fff; }
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
const regionDescriptions = {
		  "서울": "한국의 수도이자 정치, 경제, 문화의 중심지로 다양한 관광명소가 있습니다.",
		  "부산": "해운대, 광안리 등 유명한 해변과 맛집이 가득한 한국 제2의 도시입니다.",
		  "제주": "자연경관이 아름답고 힐링 여행지로 사랑받는 섬입니다.",
		  "강원": "자연이 살아있는 청정지역으로 계절별 액티비티가 풍부합니다.",
		  "전주": "한옥마을과 전통 한식으로 유명한 전통문화 도시입니다."
		  // 필요시 더 추가 가능
		};
  const modal      = document.getElementById('regionModal');
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
=======
  </main>
>>>>>>> refs/remotes/origin/master
</body>
</html>