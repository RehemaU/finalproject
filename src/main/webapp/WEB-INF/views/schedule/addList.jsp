<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* ⚠️ 로직은 건드리지 않습니다 — 로그인 없이 테스트용 userId */
    session.setAttribute("userId","test");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>나의 일정 만들기 · MYTRIP</title>

  <!-- Kakao Maps (후속 단계에서 쓸 수 있어 유지) -->
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77"></script>

  <!-- Pretendard + Montserrat -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">

  <style>
    :root{
      --border:#000;      /* 제목 밑줄 */
      --gray:#666;
      --max:1440px;
      --gutter:48px;
    }

    /* 공통 reset */
    *{margin:0;padding:0;box-sizing:border-box;}
    body{
      font-family:'Pretendard',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,'Helvetica Neue',Arial,sans-serif;
      color:#000;font-size:16px;line-height:1.45;
    }
    a{text-decoration:none;color:inherit;}

    /******** HEADER (네비게이션) ********/
    header{
      position:sticky;          /* 스크롤해도 고정 */
      top:0;
      z-index:1000;             /* ★ 메인보다 확실히 높게 */
      background:#fff;
      border-bottom:1px solid #ebebeb;
    }
    .wrap{max-width:var(--max);margin:0 auto;padding:0 var(--gutter);}
    .flex{display:flex;align-items:center;justify-content:space-between;}

    .logo{
      font-family:'Montserrat',sans-serif;font-size:32px;
      font-weight:700;letter-spacing:.5px;
    }
    .util{gap:26px;font-size:13px;text-transform:uppercase;}
    .util a{opacity:.82;transition:.2s;}
    .util a:hover{opacity:1;}

    /* 1차 카테고리 (큰 단어) */
    .tagline{padding:38px 0 22px;display:flex;gap:32px;flex-wrap:wrap;}
    .tag-item{
      position:relative;font-size:42px;font-weight:700;white-space:nowrap;cursor:pointer;
    }
    .tag-item::after{
      content:'';position:absolute;left:0;bottom:-6px;width:100%;height:3px;
      background:#000;transform:scaleX(0);transform-origin:left;transition:.25s;
    }
    .tag-item:hover::after{transform:scaleX(1);}

    /* 2차 gnb */
    .gnb{
      padding:14px 0 18px;gap:36px;
      font-size:15px;font-weight:500;white-space:nowrap;overflow-x:auto;
      border-bottom:1px solid #ebebeb;
    }
    .gnb a{flex-shrink:0;opacity:.75;} .gnb a:hover{opacity:1;}

    /******** TITLE BAR ********/
    .title-wrap{margin:48px 0 36px;}
    .title-wrap h1{font-size:34px;font-weight:700;}
    .title-wrap hr{margin-top:8px;border:0;border-top:4px solid var(--border);}

    /******** MAIN LAYOUT (두 컬럼) ********/
    .container{
      display:flex;gap:32px;
      max-width:var(--max);margin:0 auto;padding:0 var(--gutter);
      position:relative;       /* header 보다 아래, z-index 없음 */
    }
    .left{flex:0 0 500px;max-width:500px;}
    .right{flex:1 1 0%;display:flex;align-items:center;justify-content:center;}

    /* 일정 정보 폼 카드 */
    form{
      background:#fff;border:1px solid #ddd;border-radius:12px;
      padding:40px 48px;box-shadow:0 12px 24px rgba(0,0,0,.05);
    }
    form h2{font-size:24px;margin-bottom:22px;}
    label{display:block;margin:22px 0 8px;font-weight:600;font-size:15px;}
    input,select,button{
      width:100%;padding:14px;font-size:15px;border:1px solid #ccc;border-radius:6px;
    }
    button{
      margin-top:32px;background:#000;color:#fff;font-weight:600;cursor:pointer;
      transition:.2s;
    }
    button:hover{background:#111;}

    /* 오른쪽 이미지 */
    .hero-img{
      width:100%;max-width:650px;aspect-ratio:16/9;border-radius:12px;
      background:url('https://images.unsplash.com/photo-1511609524571-444c2ef1c965?auto=format&fit=crop&w=1280&q=80') center/cover no-repeat;
      box-shadow:0 14px 28px rgba(0,0,0,.12);
    }

    /******** Responsive ********/
    @media(max-width:1050px){
      .tag-item{font-size:34px}.gnb{gap:28px}
    }
    @media(max-width:880px){
      .container{flex-direction:column;gap:48px;}
      .left{max-width:none}
      .hero-img{max-width:none}
    }
    @media(max-width:640px){
      .wrap{padding:0 24px}
      .tag-item{font-size:26px}
      .util{gap:18px}
      .gnb{gap:20px;font-size:14px}
    }
  </style>
</head>
<body>

<!-- ===== HEADER ===== -->
<header>
  <div class="wrap flex">
    <a href="/" class="logo">logo</a>
    <nav class="util flex">
      <a href="/mypage">MY PAGE</a><a href="/likes">MY LIKE</a>
      <a href="/bag">BAG</a><a href="/login">LOGIN</a>
    </nav>
  </div>

  <div class="tagline wrap">
    <a class="tag-item" href="/walkthrough">Walkthrough</a>
    <a class="tag-item" href="/tour">Explore</a>
    <a class="tag-item" href="/stay">Stay</a>
    <a class="tag-item" href="/schedule">Plan</a>
    <a class="tag-item" href="/review">Share</a>
  </div>

  <nav class="gnb wrap flex">
    <a href="/tour">TOUR</a><a href="/stay">STAY</a><a href="/schedule">SCHEDULE</a>
    <a href="/review">REVIEW</a><a href="/coupon">COUPON</a><a href="/event">EVENT</a><a href="/qna">Q&A</a>
  </nav>
</header>

<!-- ===== TITLE BAR ===== -->
<section class="wrap title-wrap">
  <h1>나의 일정 만들기</h1><hr>
</section>

<!-- ===== MAIN ===== -->
<div class="container">

  <!-- 왼쪽 : 지역 + 날짜 선택 폼 -->
  <div class="left">
    <form id="dateForm" method="post" action="${pageContext.request.contextPath}/schedule/saveList">
      <h2>여행 기본 정보</h2>

      <label for="region">지역 선택</label>
      <select id="region" name="region" required>
        <option value="">-- 지역을 선택하세요 --</option>
        <option>서울</option><option>부산</option><option>제주</option><option>강원</option>
      </select>

      <label for="listName">일정 제목</label>
      <input type="text" id="listName" name="listName" required>

      <label for="startDate">시작일</label>
      <input type="date" id="startDate" required>

      <label for="endDate">종료일</label>
      <input type="date" id="endDate" required>

      <input type="hidden" name="selectedDates" id="selectedDates">
      <button type="submit">다음 →</button>
    </form>
  </div>

  <!-- 오른쪽 : 홍보 이미지 플레이스홀더 -->
  <div class="right">
    <div class="hero-img" aria-hidden="true"></div>
  </div>
</div>

<!-- ===== JS : 날짜 배열 직렬화 ===== -->
<script>
  const form = document.getElementById('dateForm');
  form.addEventListener('submit', () => {
    const s = document.getElementById('startDate').value;
    const e = document.getElementById('endDate').value;
    if (!s || !e) return;                // simple validation

    const start = new Date(s), end = new Date(e), arr = [];
    for (let d = new Date(start); d <= end; d.setDate(d.getDate() + 1)) {
      arr.push(d.toISOString().split('T')[0]);
    }
    document.getElementById('selectedDates').value = JSON.stringify(arr);
  });
</script>
</body>
</html>
