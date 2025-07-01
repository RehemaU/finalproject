<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"        %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"   %>

<!DOCTYPE html>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>일정 만들기 · MYTRIP</title>

  <!-- Pretendard + Montserrat -->
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">

  <!-- Tailwind / Swiper / Litepicker -->
  <script src="https://cdn.tailwindcss.com"></script>
  <link  rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <link  rel="stylesheet" href="https://cdn.jsdelivr.net/npm/litepicker/dist/css/litepicker.dark.css">
  <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/bundle.js"></script>

  <style>
    body{font-family:'Pretendard',sans-serif;color:#111}
    h2{font-family:'Montserrat',sans-serif;font-size:34px;font-weight:800;margin-bottom:32px}
    .form-box{max-width:680px;width:92%;background:#fff;border:1px solid #dcdcdc;border-radius:18px;padding:56px 64px;box-shadow:0 20px 48px rgba(0,0,0,.06)}
    .form-box label{font-size:17px;font-weight:600;margin-top:24px}
    .form-box input,.form-box select{width:100%;padding:18px;font-size:17px;border:1px solid #bbb;border-radius:10px;margin-top:8px}
    .form-box button{padding:18px;background:#000;color:#fff;font-size:17px;font-weight:700;border-radius:10px;margin-top:36px;transition:.25s}
    .form-box button:hover{background:#222}
    #calendarArea .container__main{font-size:16px}
    .swiper-slide{display:flex;align-items:center;justify-content:center;min-height:100vh}
  </style>
</head>
<body class="bg-[#f5f5f5]">
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <!-- Swiper -->
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
<!-- STEP 0 : 일정 시작 선택 -->
<section class="swiper-slide bg-white">
  <div class="form-box text-center">
<h1 style="font-size: 40px;">To do your Trip Plan !</h1>
    <p class="text-gray-500 mt-2 mb-8">당신의 여행을 더욱 즐겁게</p>

    <div class="flex flex-col gap-4">
      <!-- 내 일정 보기 -->
      <a href="${pageContext.request.contextPath}/schedule/myList" 
         class="block py-4 px-6 bg-[#eee] text-[#111] font-semibold rounded-lg hover:bg-[#ddd] transition">
        내가 만든 일정 목록
      </a>

      <!-- 새 일정 만들기 -->
      <button onclick="swiper.slideNext()" 
              class="py-4 px-6 bg-[#000] text-white font-semibold rounded-lg hover:bg-[#222] transition">
        새 일정 생성
      </button>
    </div>
  </div>
</section>
      <!-- STEP 1 : 날짜 -->
      <section class="swiper-slide bg-[#fafafa]">
        <div class="form-box text-center">
          <h2>STEP&nbsp;1 · 날짜 선택</h2>
          <input type="text" id="dateInput" style="display:none">
          <div id="calendarArea"></div>
        </div>
      </section>

      <!-- STEP 2 : 기본 정보 -->
      <section class="swiper-slide bg-white">
        <form class="form-box" method="post" action="${pageContext.request.contextPath}/schedule/saveList">
          <h2>STEP&nbsp;2 · 기본 정보</h2>

          <!-- 시·도 -->
          <label>시·도 선택
            <select id="region1" name="regionId" required>
              <option value="">-- 시·도 선택 --</option>
              <c:forEach var="r" items="${regionList}">
                <option value="${r.regionId}">${r.regionName}</option>
              </c:forEach>
            </select>
          </label>

          <!-- 시·군·구 -->
          <label>시·군·구 선택
            <select id="region2" name="sigunguId" required>
              <option value="">-- 시·군·구 선택 --</option>
            </select>
          </label>

          <!-- 제목 -->
          <label>일정 제목
            <input id="listName" name="listName" placeholder="예: 여름 제주 여행" required>
          </label>

          <!-- 히든 -->
          <input type="hidden" id="startDate"     name="startDate">
          <input type="hidden" id="endDate"       name="endDate">
          <input type="hidden" id="selectedDates" name="selectedDates">

          <div class="flex justify-between gap-4 mt-10">
            <button type="button" onclick="swiper.slidePrev()" class="w-1/2 bg-[#eee] text-[#333] font-semibold py-4 rounded-lg hover:bg-[#ddd]">← 날짜 선택</button>
            <button type="submit" class="w-1/2 bg-[#000] text-white font-bold py-4 rounded-lg hover:bg-[#222]">다음 단계 →</button>
          </div>
        </form>
      </section>
    </div>
  </div>

  <!-- JS ---------------------------------------------------->
  <script>
    /* ───── Swiper & Litepicker ───── */
    const swiper = new Swiper('.mySwiper',{allowTouchMove:false,speed:300});
    const picker = new Litepicker({
      element: document.getElementById('dateInput'),
      inlineMode:true, container:document.getElementById('calendarArea'),
      singleMode:false, lang:'ko', numberOfMonths:2, numberOfColumns:2, theme:'dark',
      setup:p=>{
        p.on('selected',(s,e)=>{
          if(!s||!e) return;
          const fmt=d=>d.format('YYYY-MM-DD');
          startDate.value = fmt(s); endDate.value = fmt(e);
          const arr=[],cur=s.clone();
          while(cur.isSameOrBefore(e,'day')){arr.push(fmt(cur));cur.add(1,'day');}
          selectedDates.value = JSON.stringify(arr);
          swiper.slideNext();
        });
      }
    });

    /* ───── sigungu 데이터 ───── */
    const sigunguData=[];
    <c:forEach var="s" items="${sigunguList}">
      sigunguData.push({
        regionId   : "${fn:trim(s.regionId)}",
        sigunguId  : "${fn:trim(s.sigunguId)}",
        sigunguName: "${fn:escapeXml(s.sigunguName)}"
      });
    </c:forEach>

    /* ───── 시·군·구 드롭다운 ───── */
    document.addEventListener("DOMContentLoaded",()=>{
      const region1=document.getElementById("region1");
      const region2=document.getElementById("region2");

      const updateSigunguOptions=()=>{
        const regionId=region1.value.trim();
        region2.innerHTML='<option value="">-- 시·군·구 선택 --</option>';
        sigunguData
          .filter(s=>s.regionId===regionId)
          .forEach(s=>{
            const opt=document.createElement("option");
            opt.value=s.sigunguId; opt.textContent=s.sigunguName;
            region2.appendChild(opt);
          });
      };

      region1.addEventListener("change",updateSigunguOptions);
    });
  </script>
</body>
</html>
