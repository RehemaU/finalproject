<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>나의 일정 관리 · MYTRIP</title>

  <!-- Pretendard + Montserrat -->
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet"/>

  <style>
    :root{
      --bg:#fff;          /* 배경 */
      --fg:#000;          /* 기본 글자색 */
      --gray:#666;        /* 서브 텍스트 */
      --border:#ebebeb;
      --max:1440px;
      --gutter:48px;
      --btn-bg:#000;      /* 버튼 배경(검정) */
      --btn-fg:#fff;      /* 버튼 글자(흰색) */
    }

    /* -------- 공통 리셋 -------- */
    *{margin:0;padding:0;box-sizing:border-box;}
    body{
      font-family:'Pretendard',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,'Helvetica Neue',Arial,sans-serif;
      background:var(--bg);color:var(--fg);font-size:16px;line-height:1.45;
    }
    a{text-decoration:none;color:inherit;} img{display:block;max-width:100%;}
    .wrap{max-width:var(--max);margin:0 auto;padding:0 var(--gutter);}
    .flex{display:flex}.between{justify-content:space-between}.center{align-items:center}

    /* -------- HEADER -------- */
    header{position:sticky;top:0;z-index:100;background:var(--bg);border-bottom:1px solid var(--border);}
    .util-bar{height:64px}
    .logo{display:flex;align-items:center;gap:10px;font-family:'Montserrat',sans-serif;font-size:28px;font-weight:700;letter-spacing:1.5px;}
    .util-icons{gap:28px;font-size:13px;text-transform:uppercase;}
    .search{width:26px;height:26px;border:2px solid var(--fg);border-radius:50%;position:relative;cursor:pointer;}
    .search:after{content:'';position:absolute;width:12px;height:2px;background:var(--fg);right:-4px;bottom:4px;transform:rotate(45deg);}
    .tagline{padding:38px 0 22px;display:flex;gap:26px;flex-wrap:wrap;}
    .tag-item{position:relative;font-weight:700;font-size:42px;white-space:nowrap;cursor:pointer;color:var(--fg);}
    .tag-item::after{content:'';position:absolute;left:0;bottom:-6px;width:100%;height:3px;background:var(--fg);transform:scaleX(0);transform-origin:left;transition:.25s;}
    .tag-item:hover::after{transform:scaleX(1);}
    .gnb{padding:14px 0 18px;gap:36px;font-weight:500;font-size:15px;white-space:nowrap;overflow-x:auto;border-bottom:1px solid var(--border);}
    .gnb a{opacity:.75;flex-shrink:0;}  .gnb a:hover{opacity:1;}

    /* -------- MAIN -------- */
    main{margin:230px 0 80px;}          /* ▼ 컨텐츠를 더 밑으로 */
    .section-head{text-align:center;margin-bottom:60px;}
    .section-head h2{font-size:48px;font-weight:700;}
    .section-head p{margin-top:12px;font-size:16px;color:var(--gray);}
    .main-btn{
      display:inline-block;margin-top:30px;padding:10px 28px;border-radius:6px;
      background:var(--btn-bg);color:var(--btn-fg);font-weight:600;
    }

    /* 카드(grid) */
    .mix-grid{
      display:grid;gap:24px;
      grid-template-columns:repeat(auto-fill,minmax(300px,1fr));
      grid-auto-rows:250px;
      grid-auto-flow:dense;
    }
    .tile{position:relative;border:1px solid var(--border);border-radius:8px;overflow:hidden;cursor:pointer;}
    .tile .bg{width:100%;height:100%;background:center/cover no-repeat;}
    .tile .info{
      position:absolute;left:16px;bottom:16px;color:#fff;
      text-shadow:0 1px 4px rgba(0,0,0,.55);
      display:flex;flex-direction:column;gap:6px;
    }
    .info h4{font-size:24px;font-weight:700;}
    .info span{font-size:14px;line-height:1.4;}
    .info .btn{
      /* ▶︎ a → span 으로 변경된 버튼 */
      margin-top:6px;align-self:start;
      padding:4px 14px;font-size:13px;border-radius:4px;
      background:var(--btn-bg);color:var(--btn-fg);font-weight:500;
    }

    /* -------- Responsive -------- */
    @media(max-width:1100px){
      .tag-item{font-size:34px}
    }
    @media(max-width:760px){
      .wrap{padding:0 24px}
      .util-bar{height:56px}
      .gnb{gap:20px;font-size:14px}
      .tag-item{font-size:26px}
      .section-head h2{font-size:36px}
      .mix-grid{grid-auto-rows:200px}
      main{margin:200px 0 60px;}
    }
  </style>
</head>
<body>

  <!-- ===== HEADER ===== -->
  <header>
    <div class="util-bar wrap flex between center">
      <a href="/" class="logo">logo</a>
      <div class="util-icons flex center">
        <a class="icon" href="/mypage">MY PAGE</a>
        <a class="icon" href="/likes">MY LIKE</a>
        <a class="icon" href="/bag">BAG</a>
        <a class="icon" href="/login">LOGIN</a>
        <span class="search" aria-label="Search"></span>
      </div>
    </div>
    <div class="tagline wrap">
      <a class="tag-item" href="/walkthrough">Walkthrough</a>
      <a class="tag-item" href="/tour">Explore</a>
      <a class="tag-item" href="/stay">Stay</a>
      <a class="tag-item" href="/schedule">Plan</a>
      <a class="tag-item" href="/review">Share</a>
    </div>
    <nav class="gnb wrap flex center">
      <a href="/tour">TOUR</a><a href="/stay">STAY</a><a href="/schedule">SCHEDULE</a>
      <a href="/review">REVIEW</a><a href="/coupon">COUPON</a>
      <a href="/event">EVENT</a><a href="/qna">Q&A</a>
    </nav>
  </header>

  <!-- ===== MAIN ===== -->
  <main class="wrap">
    <!-- 타이틀 / 부제 / 버튼 -->
    <section class="section-head">
      <br><br><br><br><br><h2>나의 일정 관리</h2>
      <p>Subheading with description of your shopping site</p>
      <a href="/schedule/addList" class="main-btn">바로 만들기</a>
    </section>
<br><br><br>
    <!-- LIST & CREATE 카드 -->
    <section class="mix-grid">
      <!-- 내가 만든 일정 -->
      <a class="tile" href="/schedule/list">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1590487989353-cdffd4e5b8c9?auto=format&fit=crop&w=900&q=80')"></div>
        <div class="info">
          <h4>내가 만든 일정</h4>
          <span>내가 만든 일정을 확인하고 후기<br/>를 남겨보세요</span>
          <span class="btn">LIST</span>
        </div>
      </a>
<br><br><br><br><br><br><br>
      <!-- 새 일정 만들기 -->
      <a class="tile" href="/schedule/addList">
        <div class="bg" style="background-image:url('https://images.unsplash.com/photo-1586769852755-52c8e843f063?auto=format&fit=crop&w=900&q=80')"></div>
        <div class="info">
          <h4>새 일정 만들기</h4>
          <span>나만의 여행계획을 통해 여행을<br/>더욱 흥미롭게 만들어보세요</span>
          <span class="btn">CREATE</span>
        </div>
      </a>
    </section>
  </main>
</body>
</html>
