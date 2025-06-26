<!-- head.jsp : 공통 <head> -->
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
    /* ---------- 공통 변수 & 리셋 ---------- */
    :root{
      --bg:#fff; --fg:#000; --gray:#666; --border:#ebebeb;
      --max:1440px; --gutter:48px;
    }
    *{margin:0;padding:0;box-sizing:border-box;}
    body{
      font-family:'Pretendard',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,'Helvetica Neue',Arial,sans-serif;
      background:var(--bg);color:var(--fg);font-size:16px;line-height:1.45;
    }
    a{color:inherit;text-decoration:none;}
    img{display:block;max-width:100%;}
    .wrap{max-width:var(--max);margin:0 auto;padding:0 var(--gutter);}
    .flex{display:flex}.between{justify-content:space-between}.center{align-items:center}

    /* ---------- HEADER & NAV ---------- */
    header{position:sticky;top:0;z-index:100;background:var(--bg);border-bottom:1px solid var(--border);}
    .util-bar{height:64px}
    .logo{
      display:flex;align-items:center;gap:10px;
      font-family:'Montserrat',sans-serif;font-size:28px;font-weight:700;letter-spacing:1.5px;
    }
    .util-icons{gap:28px;font-size:13px;text-transform:uppercase;}
    .search{width:26px;height:26px;border:2px solid var(--fg);border-radius:50%;position:relative;cursor:pointer;}
    .search:after{content:'';position:absolute;width:12px;height:2px;background:var(--fg);right:-4px;bottom:4px;transform:rotate(45deg);}
    .tagline{padding:38px 0 22px;display:flex;gap:26px;flex-wrap:wrap;}
    .tag-item{position:relative;font-weight:700;font-size:42px;white-space:nowrap;cursor:pointer;}
    .tag-item::after{
      content:'';position:absolute;left:0;bottom:-6px;width:100%;height:3px;background:var(--fg);
      transform:scaleX(0);transform-origin:left;transition:.3s;
    }
    .tag-item:hover::after{transform:scaleX(1);}
    .gnb{
      padding:14px 0 18px;gap:36px;font-weight:500;font-size:15px;
      white-space:nowrap;overflow-x:auto;border-bottom:1px solid var(--border);
    }
    .gnb a{opacity:.75;flex-shrink:0;} .gnb a:hover{opacity:1;}

    /* ---------- 메인 컨텐츠 레이아웃 ---------- */
    main{margin:60px 0;}

    /* ① Intro Grid */
    .grid{display:grid;gap:32px;grid-template-columns:1.7fr 1fr 1fr;}
    .hero{position:relative;aspect-ratio:3/4;background:center/cover no-repeat url('');}
    .hero h2{position:absolute;left:32px;bottom:32px;color:#fff;font-size:40px;font-weight:700;}
    .card{border:1px solid var(--border);display:flex;flex-direction:column;}
    .card-img{aspect-ratio:4/5;background:center/cover no-repeat;}
    .card-body{padding:22px 24px;display:flex;flex-direction:column;gap:10px;}
    .card-body h3{font-size:19px;font-weight:700;}
    .card-body p{font-size:15px;color:var(--gray);}
    .stack{display:grid;gap:24px;}

    /* ② 공통 섹션 제목 */
    .section-title{font-size:28px;font-weight:700;margin:80px 0 24px;}

    /* ③ Mix-Grid (HOT TOUR / HOTEL) */
    .mix-grid{
      display:grid;gap:24px;
      grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
      grid-auto-rows:240px;grid-auto-flow:dense;
    }
    .tile{position:relative;border:1px solid var(--border);border-radius:8px;overflow:hidden;cursor:pointer;}
    .tile.large{grid-column:span 2;grid-row:span 2;}
    .tile .bg{width:100%;height:100%;background:center/cover no-repeat;}
    .tile .info{
      position:absolute;left:16px;bottom:16px;color:#fff;
      text-shadow:0 1px 4px rgba(0,0,0,.55);display:flex;flex-direction:column;gap:4px;
    }
    .info h4{font-size:20px;font-weight:700;}
    .info span{font-size:14px;}

    /* ---------- 반응형 ---------- */
    @media(max-width:1100px){
      .tag-item{font-size:34px}
      .grid{grid-template-columns:1fr 1fr}
    }
    @media(max-width:760px){
      .wrap{padding:0 24px}
      .tag-item{font-size:26px}
      .grid{grid-template-columns:1fr}
      .gnb{gap:20px;font-size:14px}
      .util-bar{height:56px}
      .section-title{font-size:24px;margin:60px 0 20px;}
      .mix-grid{grid-auto-rows:200px;}
    }
  </style>
</head>