<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    session.setAttribute("userId", "test");
    List<String> selectedDates = (List<String>) session.getAttribute("selectedDates");
    String listName = (String) session.getAttribute("listName");
    String calanderListId = (String) session.getAttribute("calanderListId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title><c:out value="${listName != null ? listName : 'Create Schedule'}" /> · MYTRIP</title>

  <!-- 폰트 & 스타일 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">

  <!-- Litepicker -->
  <link href="https://cdn.jsdelivr.net/npm/litepicker/dist/css/litepicker.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/bundle.js"></script>

  <style>
    :root {
      --txt:#111;--sub:#767676;--bg:#fdfdfd;--bd:#e4e4e4;
      --accent:#000;--radius:14px;--max:1440px;--gutter:48px;
    }
    * {margin:0;padding:0;box-sizing:border-box}
    body {font-family:'Pretendard',sans-serif;background:#fff;color:var(--txt);}
    a {text-decoration:none;color:inherit}

    header {
      position:sticky;top:0;z-index:1000;background:#fff;
      border-bottom:1px solid #ebebeb;padding:30px var(--gutter) 10px;
    }
    .wrap {max-width:var(--max);margin:0 auto;padding:0 var(--gutter);}
    .flex {display:flex;align-items:center;justify-content:space-between;}
    .logo {font-family:'Montserrat',sans-serif;font-size:32px;font-weight:700;}
    .util {gap:26px;font-size:13px;text-transform:uppercase;}
    .util a {opacity:.82;transition:.2s;} .util a:hover {opacity:1;}

    .tagline {
      padding:38px 0 22px;display:flex;gap:32px;flex-wrap:wrap;
    }
    .tag-item {
      position:relative;font-size:36px;font-weight:700;white-space:nowrap;cursor:pointer;
    }
    .tag-item::after {
      content:'';position:absolute;left:0;bottom:-6px;width:100%;height:3px;
      background:#000;transform:scaleX(0);transform-origin:left;transition:.25s;
    }
    .tag-item:hover::after {transform:scaleX(1);}

    .gnb {
      padding:14px 0 18px;gap:36px;
      font-size:15px;font-weight:500;white-space:nowrap;overflow-x:auto;
      border-bottom:1px solid #ebebeb;
    }
    .gnb a {flex-shrink:0;opacity:.75;} .gnb a:hover {opacity:1;}

    .container {
      display:flex;gap:40px;max-width:var(--max);
      margin:48px auto;padding:0 var(--gutter);
    }
    .left {flex:0 0 32%;}
    .right {flex:1 1 0%;display:flex;justify-content:center;}

    form {
      background:#fff;border:1px solid var(--bd);border-radius:12px;
      padding:40px 48px;box-shadow:0 12px 24px rgba(0,0,0,.05);
    }
    form h3 {font-size:24px;margin-bottom:24px}
    label {display:block;margin:22px 0 8px;font-weight:600}
    input,select,button {
      width:100%;padding:14px;border:1px solid #ccc;
      border-radius:8px;font-size:15px;
    }
    button {
      margin-top:26px;background:#000;color:#fff;font-weight:600;cursor:pointer;
      transition:.2s;
    }
    button:hover {background:#222}

    .calendar-box {
      background:#fff;border:1px solid var(--bd);border-radius:12px;
      padding:28px 30px;box-shadow:0 12px 24px rgba(0,0,0,.05);
    }
    .calendar-box h4 {
      margin-bottom:20px;font-size:20px;font-weight:700;text-align:center
    }

    @media(max-width:880px){
      .container {flex-direction:column}
      .left,.right {flex:none}
    }
  </style>
</head>
<body>

<!-- HEADER -->
<header>
  <div class="wrap flex">
    <a href="/" class="logo">MYTRIP</a>
    <nav class="util flex">
      <a href="/mypage">MY PAGE</a><a href="/likes">MY LIKE</a>
      <a href="/bag">BAG</a><a href="/login">LOGIN</a>
    </nav>
  </div>

  <div class="wrap tagline">
    <a class="tag-item" href="/walkthrough">Walkthrough</a>
    <a class="tag-item" href="/tour">Explore</a>
    <a class="tag-item" href="/stay">Stay</a>
    <a class="tag-item" href="/schedule">Plan</a>
    <a class="tag-item" href="/review">Share</a>
  </div>

  <nav class="wrap gnb flex">
    <a href="/tour">TOUR</a><a href="/stay">STAY</a><a href="/schedule">SCHEDULE</a>
    <a href="/review">REVIEW</a><a href="/coupon">COUPON</a>
    <a href="/event">EVENT</a><a href="/qna">Q&A</a>
  </nav>
</header>

<!-- MAIN -->
<div class="container">

  <!-- LEFT: 기본 입력 폼 -->
  <div class="left">
    <form id="scheduleForm" method="post" action="${pageContext.request.contextPath}/schedule/saveList">
      <h3>여행지 & 날짜 선택</h3>

      <label for="region">지역</label>
      <select id="region" name="region" required>
        <option value="">-- 지역을 선택하세요 --</option>
        <option>서울</option><option>부산</option><option>제주</option><option>강원</option>
      </select>

      <label for="listName">일정 제목</label>
      <input type="text" id="listName" name="listName" required>

      <label for="startDate">시작일</label>
      <input type="date" id="startDate" readonly required>

      <label for="endDate">종료일</label>
      <input type="date" id="endDate" readonly required>

      <input type="hidden" name="selectedDates" id="selectedDates">

      <button type="submit">다음 단계 →</button>
    </form>
  </div>

  <!-- RIGHT: 달력 -->
  <div class="right">
    <div class="calendar-box">
      <h4>날짜를 선택하세요</h4>
      <input type="text" id="dateInput" style="display:none;">
      <div id="calendarArea"></div>
    </div>
  </div>

</div>

<!-- SCRIPT -->
<script>
const picker = new Litepicker({
  element: document.getElementById('dateInput'),
  inlineMode: true,
  container: document.getElementById('calendarArea'),
  singleMode: false,
  lang: 'ko',
  numberOfMonths: 2,
  numberOfColumns: 2,
  tooltipText: { one: '일', other: '일' },
  tooltipPosition: 'bottom',
  setup: (pickerInstance) => {
    pickerInstance.on('selected', (startDate, endDate) => {
      if (!startDate || !endDate) return;
      document.getElementById('startDate').value = startDate.format('YYYY-MM-DD');
      document.getElementById('endDate').value = endDate.format('YYYY-MM-DD');

      const arr = [], s = startDate.clone();
      while (s.isSameOrBefore(endDate, 'day')) {
        arr.push(s.format('YYYY-MM-DD'));
        s.add(1, 'day');
      }
      document.getElementById('selectedDates').value = JSON.stringify(arr);
    });
  }
});

document.getElementById('scheduleForm').addEventListener('submit', (e) => {
  const sd = document.getElementById('startDate').value;
  const ed = document.getElementById('endDate').value;
  if (!sd || !ed) {
    alert('날짜를 먼저 선택하세요!');
    e.preventDefault();
  }
});
</script>
</body>
</html>
