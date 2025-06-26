<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MYTRIP – Walkthrough · Explore · Stay · Plan · Share</title>

  <!-- Pretendard + Montserrat -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet" />

  <style>
    :root{--bg:#fff;--fg:#000;--gray:#666;--border:#ebebeb;--max:1440px;--gutter:48px;}
    *{box-sizing:border-box;margin:0;padding:0;}
    body{font-family:'Pretendard',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,'Helvetica Neue',Arial,sans-serif;background:var(--bg);color:var(--fg);font-size:16px;line-height:1.45;}
    a{color:inherit;text-decoration:none;}img{display:block;max-width:100%;}
    .wrap{max-width:var(--max);margin:0 auto;padding:0 var(--gutter);}
    .flex{display:flex}.between{justify-content:space-between}.center{align-items:center}

    /* ---------- HEADER (생략: 기존과 동일) ---------- */
    header{position:sticky;top:0;z-index:100;background:var(--bg);border-bottom:1px solid var(--border);}
    .util-bar{height:64px}.logo{display:flex;align-items:center;gap:10px;font-family:'Montserrat',sans-serif;font-size:28px;font-weight:700;letter-spacing:1.5px;}
    .util-icons{gap:28px;font-size:13px;text-transform:uppercase;}
    .search{width:26px;height:26px;border:2px solid var(--fg);border-radius:50%;position:relative;cursor:pointer;}
    .search:after{content:'';position:absolute;width:12px;height:2px;background:var(--fg);right:-4px;bottom:4px;transform:rotate(45deg);}
    .tagline{padding:38px 0 22px;display:flex;gap:26px;flex-wrap:wrap;}
    .tag-item{position:relative;font-weight:700;font-size:42px;white-space:nowrap;cursor:pointer;}
    .tag-item::after{content:'';position:absolute;left:0;bottom:-6px;width:100%;height:3px;background:var(--fg);transform:scaleX(0);transform-origin:left;transition:.3s;}
    .tag-item:hover::after{transform:scaleX(1);}
    .gnb{padding:14px 0 18px;gap:36px;font-weight:500;font-size:15px;white-space:nowrap;overflow-x:auto;border-bottom:1px solid var(--border);}
    .gnb a{opacity:.75;flex-shrink:0;} .gnb a:hover{opacity:1;}

    /* ---------- INTRO GRID ---------- */
    main{margin:60px 0;}
    .grid{display:grid;gap:32px;grid-template-columns:1.7fr 1fr 1fr;}
    .hero{position:relative;aspect-ratio:3/4;background:center/cover no-repeat url('');}
    .hero h2{position:absolute;left:32px;bottom:32px;color:#fff;font-size:40px;font-weight:700;}
    .card{border:1px solid var(--border);display:flex;flex-direction:column;}
    .card-img{aspect-ratio:4/5;background:center/cover no-repeat;}
    .card-body{padding:22px 24px;display:flex;flex-direction:column;gap:10px;}
    .card-body h3{font-size:19px;font-weight:700;} .card-body p{font-size:15px;color:var(--gray);}
    .stack{display:grid;gap:24px;}

    /* ---------- NEW “MIX-GRID” 스타일 ---------- */
    .section-title{font-size:28px;font-weight:700;margin:80px 0 24px;}
    .mix-grid{
      display:grid;
      gap:24px;
      grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
      grid-auto-rows:240px;
      grid-auto-flow:dense;   /* 빈공간 없게 채우기 */
    }
    .tile{position:relative;border:1px solid var(--border);border-radius:8px;overflow:hidden;cursor:pointer;}
    .tile.large{grid-column:span 2;grid-row:span 2;}        /* 큰 카드 */
    .tile .bg{width:100%;height:100%;background:center/cover no-repeat;}
    .tile .info{
      position:absolute;left:16px;bottom:16px;color:#fff;text-shadow:0 1px 4px rgba(0,0,0,.5);
      display:flex;flex-direction:column;gap:4px;
      
    }
    .info h4{font-size:20px;font-weight:700;}
    .info span{font-size:14px;}

    /* ---------- Responsive ---------- */
    @media(max-width:1100px){.tag-item{font-size:34px}.grid{grid-template-columns:1fr 1fr}}
    @media(max-width:760px){
      .wrap{padding:0 24px}.tag-item{font-size:26px}.grid{grid-template-columns:1fr}
      .gnb{gap:20px;font-size:14px}.util-bar{height:56px}
      .section-title{font-size:24px;margin:60px 0 20px;}
      .mix-grid{grid-auto-rows:200px;}
    }
  </style>
</head>
<body>
  <!-- ===== HEADER ===== -->
  <header>
    <div class="util-bar wrap flex between center">
      <a href="/" class="logo">logo</a>
      <div class="util-icons flex center">
        <a class="icon" href="/mypage">MY PAGE</a><a class="icon" href="/likes">MY LIKE</a>
        <a class="icon" href="/bag">BAG</a><a class="icon" href="/login">LOGIN</a>
        <span class="search" aria-label="Search"></span>
      </div>
    </div>
    <div class="tagline wrap">
      <a class="tag-item" href="/walkthrough">Walkthrough</a><a class="tag-item" href="/tour">Explore</a>
      <a class="tag-item" href="/stay">Stay</a><a class="tag-item" href="/schedule">Plan</a><a class="tag-item" href="/review">Share</a>
    </div>
    <nav class="gnb wrap flex center">
      <a href="/tour">TOUR</a><a href="/stay">STAY</a><a href="/schedule">SCHEDULE</a>
      <a href="/review">REVIEW</a><a href="/coupon">COUPON</a><a href="/event">EVENT</a><a href="/qna">Q&A</a>
    </nav>
  </header>

  <!-- ===== MAIN ===== -->
  <main class="wrap">
    <!-- Intro grid (그대로) -->
    <section class="grid">
      <div class="hero"><h2></h2></div>
      <article class="card">
        <div class="card-img"></div>
        <div class="card-body"><h3>여행 계획을 세우기 좋은 요즘</h3><p>지역별 추천 스팟과 숙소를 한눈에 확인해보세요.</p></div>
      </article>
      <div class="stack">
        <article class="card"><div class="card-img"></div><div class="card-body"><h3>마이페이지에서 내 여행기록 확인</h3><p>내가 찜한 장소, 예약 내역, 후기를 쉽게 관리해보세요.</p></div></article>
        <article class="card"><div class="card-img"></div><div class="card-body"><h3>여행의 추억을 공유해보세요</h3><p>작성한 일정을 바탕으로 후기를 남기고 다른 사람과 공유해요.</p></div></article>
      </div>
    </section>

    <!-- ===== HOT TOUR (mix-grid) ===== -->
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

    <!-- ===== POPULAR HOTEL (mix-grid) ===== -->
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
