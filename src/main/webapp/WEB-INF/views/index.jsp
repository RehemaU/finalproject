<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>

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
  </main>
</body>
</html>