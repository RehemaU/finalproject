<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"        %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"   %>

<!DOCTYPE html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>후기 · MYTRIP</title>

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
    .swiper-slide{display:flex;align-items:center;justify-content:center;min-height:72.5vh}
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
<h1 style="font-size: 40px;">Share your Travel Plan</h1>
    <p class="text-gray-500 mt-2 mb-8">모두의 여행을 더욱 즐겁게</p>

    <div class="flex flex-col gap-4">
      <a button onclick="location.href='/editor/planlist'"
         class="block py-4 px-6 bg-[#eee] text-[#111] font-semibold rounded-lg hover:bg-[#ddd] transition">
        모든 후기 보러가기
      </a>

      <button onclick="location.href='/schedule/myList'"
              class="py-4 px-6 bg-[#000] text-white font-semibold rounded-lg hover:bg-[#222] transition">
        나의 후기 작성하기
      </button>
    </div>
  </div>
</section>

    </div>
  </div>

</body>
</html>
