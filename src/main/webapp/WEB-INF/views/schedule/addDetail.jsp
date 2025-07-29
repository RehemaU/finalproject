<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.List"%>
<%
  List<String> selectedDates = (List<String>)session.getAttribute("selectedDates");
  String listName       = (String)session.getAttribute("listName");
  String calanderListId = (String)session.getAttribute("calanderListId");
  if(selectedDates==null){
      out.println("<script>alert('잘못된 접근입니다.');location.href='"
                  +request.getContextPath()+"/schedule/addList';</script>");
      return;
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><%=listName%> · 일정 상세 입력</title>

<!-- 글꼴 -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">

<!-- Kakao Map -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=services,clusterer"></script>

<style>
:root{
  --bd:#e4e4e4; --bg:#fdfdfd; --subbg:#fafafa;
  --pill:#f1f1f1; --txt:#111; --radius:14px
}

/* ───── 공통 기본 ───── */
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Pretendard','Inter',sans-serif;background:var(--bg);color:var(--txt)}
h2{font-size:28px;font-weight:700;padding:32px 48px 4px;white-space:nowrap}

/* ───── 3단 레이아웃 ───── */
.page-wrap{display:flex;height:calc(100vh - 96px)}
.sidebar, .plan-panel{
  width:360px;min-width:360px;background:var(--subbg);
  border-right:1px solid var(--bd);padding:26px 24px;overflow-y:auto
}
.plan-panel{background:#fff}          /* 선택 일정 패널은 흰 배경 */
#map{flex:1 1 0%}

/* ───── 네비게이션 내부 ───── */
.day-tabs,.cat-tabs{display:flex;gap:12px;margin-bottom:22px}
.day-tab,.cat-tab{
  flex:1;padding:10px 0;border-radius:var(--radius);background:var(--pill);
  text-align:center;font-weight:600;cursor:pointer;user-select:none
}
.day-tab.active,.cat-tab.active{background:#000;color:#fff}

select,input[type=text]{
  width:100%;padding:11px 14px;margin-bottom:14px;font-size:14px;
  border:1px solid var(--bd);border-radius:var(--radius);background:#fff
}
button.filter-btn{
  width:100%;padding:11px 0;margin-bottom:14px;border:none;
  border-radius:var(--radius);background:#000;color:#fff;font-weight:600;cursor:pointer
}

#listBox{
  max-height:360px;overflow-y:auto;display:flex;flex-direction:column;gap:12px
}
.spot-btn{
  all:unset;display:flex;align-items:center;gap:14px;
  padding:14px 16px;border:1px solid var(--bd);border-radius:var(--radius);
  background:#fff;cursor:pointer;transition:.25s
}
.spot-btn:hover{box-shadow:0 4px 12px rgba(0,0,0,.08);transform:translateY(-2px)}

#pagination{
  display:flex;justify-content:center;gap:8px;margin-top:6px;flex-wrap:wrap
}
#pagination button{
  all:unset;min-width:34px;padding:6px 0;border:1px solid var(--bd);
  border-radius:10px;font-size:13px;text-align:center;cursor:pointer
}
#pagination button.active,#pagination button:hover{background:#000;color:#fff;border-color:#000}

/* ───── 선택 일정 패널 ───── */
.plan-panel h3{font-size:18px;font-weight:700;margin-bottom:16px}
#selectedBox{
  max-height:calc(100vh - 270px);   /* 패널 내부 높이에 맞춰 자동 스크롤 */
  overflow-y:auto;display:flex;flex-direction:column;gap:10px;
  border:1px solid var(--bd);border-radius:var(--radius);
  padding:12px;background:var(--subbg)
}
.entry{
  border:1px solid var(--bd);border-radius:12px;padding:12px 14px;background:#fff
}
.entry strong{display:block;margin-bottom:6px;font-weight:600}
.entry input[type=datetime-local]{
  width:100%;padding:8px;border:1px solid var(--bd);border-radius:8px;
  font-size:13px;margin-top:4px
}
.remove-btn {
  margin-top:8px;
  padding:4px 8px;
  background:#111;         /* 버튼 기본 배경: 거의 검정 */
  color:#fff;
  border:none;
  border-radius:4px;
  cursor:pointer;
  font-size:12px;
}
.remove-btn:hover {
  background:#333;         /* hover 시 진한 회색 */
}
#scheduleForm{display:flex;flex-direction:column;gap:14px}
#scheduleForm button[type=submit]{
  all:unset;width:100%;padding:14px 0;border-radius:var(--radius);
  background:#000;color:#fff;font-weight:600;text-align:center;cursor:pointer
}
#scheduleForm button[type=submit]:hover{background:#222}

/* ───── 수동 주소 추가 섹션 ───── */
.manual-section{
  border-top:1px solid var(--bd);padding-top:20px;margin-top:20px
}
.manual-section h4{
  font-size:14px;font-weight:600;margin-bottom:8px;color:#333
}
.manual-section input[type=text]{
  margin-bottom:8px
}
.manual-section input[type=text]:first-of-type{
  font-weight:500
}

/* ───── 모바일 ───── */
@media(max-width:900px){
  .page-wrap{flex-direction:column}
  .sidebar,.plan-panel{width:100%;min-width:0;border-right:0;border-bottom:1px solid var(--bd)}
  #map{height:58vh}
}
</style>
</head>

<body>
<h2><c:out value="${listName}"/></h2>

<div class="page-wrap">

  <!-- ───── SIDE BAR : 장소 검색 / 선택 ───── -->
  <aside class="sidebar" id="leftSidebar">
    <div class="day-tabs">
      <c:forEach items="${selectedDates}" varStatus="s">
        <div class="day-tab ${s.index==0?'active':''}" data-day="${s.index+1}">Day ${s.index+1}</div>
      </c:forEach>
    </div>

    <div class="cat-tabs">
      <div class="cat-tab active" data-type="accom">숙소</div>
      <div class="cat-tab"        data-type="tour">관광지</div>
    </div>

    <select id="region1" onchange="updateSigunguOptions()">
      <option value="">시·도 선택</option>
      <c:forEach var="r" items="${regionList}">
        <option value="${r.regionId}">${r.regionName}</option>
      </c:forEach>
    </select>

    <select id="region2">
      <option value="">시·군·구 선택</option>
    </select>

    <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
    <button class="filter-btn" id="applyFilterBtn">조회</button>

    <div id="listBox"></div>
    <div id="pagination"></div>
    
    <div class="manual-section">
      <h4>📍 직접 주소 추가</h4>
      <input type="text" id="manualPlaceName" placeholder="장소명 (필수)" required />
      <input type="text" id="manualAddress" placeholder="예: 서울시 중구 세종대로 110" required />
      <button class="filter-btn" id="addByAddressBtn">주소로 추가</button>
    </div>
  </aside>

  <!-- ───── PLAN PANEL : 선택 일정 카드 & 저장 ───── -->
  <aside class="plan-panel">
    <h3>선택 일정</h3>

    <form id="scheduleForm" action="${pageContext.request.contextPath}/schedule/saveDetail" method="post">
      <input type="hidden" name="calanderListId" value="<%=calanderListId%>">

      <div id="selectedBox"></div>

      <button type="submit">일정 저장하기</button>
    </form>
  </aside>

  <!-- ───── 지도 ───── -->
  <div id="map"></div>
</div>

<!-- ───────── JS : 시·군·구 드롭다운 ───────── -->
<script>
  const sigunguData = [];
  <c:forEach var="s" items="${sigunguList}">
    sigunguData.push({
      regionId   : "${fn:trim(s.regionId)}",
      sigunguId  : "${fn:trim(s.sigunguId)}",
      sigunguName: "${fn:escapeXml(s.sigunguName)}"
    });
  </c:forEach>

  function updateSigunguOptions(){
    const rId=document.getElementById('region1').value;
    const region2=document.getElementById('region2');
    region2.innerHTML='<option value="">시·군·구 선택</option>';
    sigunguData.filter(s=>s.regionId===rId)
               .forEach(s=>{
                 const opt=document.createElement('option');
                 opt.value=s.sigunguId; opt.textContent=s.sigunguName;
                 region2.appendChild(opt);
               });
  }
</script>

<script>
document.addEventListener('DOMContentLoaded',function(){
  var currentDayNo=1,currentType='accom',currentPage=1,itemsPerPage=6,
      map,accomList=[],tourList=[];
  var contextPath = '<c:out value="${pageContext.request.contextPath}"/>';
  
  // ★★★ 수정된 getCode 함수 ★★★
  var getCode = function(obj) {
    console.log('=== getCode 함수 호출 ===');
    console.log('입력 객체:', obj);
    
    var result = '';
    
    // 관광지(Tour)의 경우
    if (obj.tourId !== undefined) {
      result = String(obj.sigunguId || '').trim();
      console.log('관광지 sigunguId:', result);
    }
    // 숙소(Accommodation)의 경우
    else if (obj.accomId !== undefined) {
      // 여러 가능한 필드명 시도
      result = String(obj.sigunguCode || obj.sigunguId || obj.sigungu_id || '').trim();
      console.log('숙소 sigungu 코드:', result);
      console.log('사용된 필드: sigunguCode =', obj.sigunguCode, ', sigunguId =', obj.sigunguId);
    }
    
    console.log('getCode 결과:', result);
    return result;
  };

  /* Day / Cat 탭 */
  document.querySelectorAll('.day-tab').forEach(function(t){
    t.onclick=function(e){
      document.querySelectorAll('.day-tab').forEach(function(x){x.classList.remove('active');});
      e.currentTarget.classList.add('active'); 
      currentDayNo=+e.currentTarget.dataset.day;
      console.log('Day 탭 클릭:', currentDayNo);
    };
  });
  
  document.querySelectorAll('.cat-tab').forEach(function(t){
    t.onclick=function(e){
      document.querySelectorAll('.cat-tab').forEach(function(x){x.classList.remove('active');});
      e.currentTarget.classList.add('active'); 
      currentType=e.currentTarget.dataset.type;
      currentPage=1; 
      renderPage();
    };
  });

  /* Kakao map */
  kakao.maps.load(function(){
    map=new kakao.maps.Map(document.getElementById('map'),{
      center:new kakao.maps.LatLng(37.5665,126.9780),level:6
    });
  });

  /* 데이터 fetch */
  Promise.all([
    fetch(contextPath + '/accommodation/listAll').then(function(r){return r.json();}),
    fetch(contextPath + '/listAll').then(function(r){return r.json();})
  ]).then(function(results){
    var a = results[0];
    var t = results[1];
    
    console.log('=== 원본 데이터 확인 ===');
    console.log('숙소 데이터 샘플:', a.slice(0, 2));
    console.log('관광지 데이터 샘플:', t.slice(0, 2));
    
    accomList=a.map(function(o){
      return Object.assign({}, o, {accomLat:+o.accomLat,accomLon:+o.accomLon});
    });
    tourList=t.map(function(o){
      return Object.assign({}, o, {tourLat:+o.tourLat,tourLon:+o.tourLon});
    });
    
    console.log('가공된 숙소 데이터 샘플:', accomList.slice(0, 2));
    console.log('가공된 관광지 데이터 샘플:', tourList.slice(0, 2));
    
    renderPage();
  }).catch(console.error);

  /* 필터 */
  document.getElementById('applyFilterBtn').onclick=function(){
    currentPage=1;
    renderPage();
  };
  
  document.getElementById('searchInput').addEventListener('keydown',function(e){
    if(e.key==='Enter'){
      e.preventDefault();
      document.getElementById('applyFilterBtn').click();
    }
  });

  /* HTML 이스케이프 함수 */
  function escapeHtml(text) {
    var map = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, function(m) { return map[m]; });
  }

  /* 일정 삭제 함수 */
  window.removeSpot = function(button) {
    if (confirm('이 일정을 삭제하시겠습니까?')) {
      var entry = button.closest('.entry');
      entry.remove();
    }
  };

  /* ★★★ 수정된 addSpot 함수 ★★★ */
function addSpot(loc) {
  console.log('=== addSpot 함수 호출 ===');
  console.log('loc 객체:', loc);
  console.log('currentDayNo:', currentDayNo);

  if (!loc || !loc.name) {
    console.error('loc 또는 loc.name이 없습니다:', loc);
    return;
  }

  if (!currentDayNo) {
    console.error('currentDayNo가 없습니다:', currentDayNo);
    return;
  }

  var pos = new kakao.maps.LatLng(loc.lat, loc.lon);
  map.setCenter(pos);
  new kakao.maps.Marker({ map: map, position: pos, title: loc.name });

  var card = document.createElement('div');
  card.className = 'entry';

  var dayNoValue = currentDayNo;
  var spotIdValue = loc.id;
  var displayText = '[Day ' + dayNoValue + '] ' + loc.name;

  // 🌟 Day1 ~ DayN에 해당하는 날짜 가져오기
  var dateStr = '';
  <% if (selectedDates != null) { %>
    var selectedDates = <%= new com.google.gson.Gson().toJson(selectedDates) %>;
    if (selectedDates.length >= currentDayNo) {
      dateStr = selectedDates[currentDayNo - 1]; // 'YYYY-MM-DD'
    }
  <% } %>

  var html = '';
  html += '<input type="hidden" name="dayNos" value="' + dayNoValue + '">';
  html += '<input type="hidden" name="spotIds" value="' + spotIdValue + '">';

  if (loc.isManual) {
    html += '<input type="hidden" name="isManual" value="true">';
    html += '<input type="hidden" name="manualNames" value="' + escapeHtml(loc.name) + '">';
    html += '<input type="hidden" name="manualAddresses" value="' + escapeHtml(loc.address) + '">';
    html += '<input type="hidden" name="manualLats" value="' + loc.lat + '">';
    html += '<input type="hidden" name="manualLons" value="' + loc.lon + '">';
    displayText += ' (직접 입력: ' + loc.address + ')';
  } else {
    html += '<input type="hidden" name="isManual" value="false">';
    html += '<input type="hidden" name="manualNames" value="">';
    html += '<input type="hidden" name="manualAddresses" value="">';
    html += '<input type="hidden" name="manualLats" value="">';
    html += '<input type="hidden" name="manualLons" value="">';
  }

  html += '<strong>' + escapeHtml(displayText) + '</strong>';

  // datetime-local 기본값 및 min 값 설정
  const now = new Date();
  const pad = n => n.toString().padStart(2, '0');

  let defaultDate = '';
  let minDateTime = now.toISOString().slice(0, 16); // 기본 min: 현재시각

  if (dateStr) {
    defaultDate = dateStr + 'T09:00'; // 시작시간 기본값 오전 9시
    const dateOnly = new Date(dateStr);
    if (dateOnly > now) {
      minDateTime = dateStr + 'T00:00';
    }
  }

  html += '<br>시작 <input type="datetime-local" name="startTimes" required value="' + defaultDate + '" min="' + minDateTime + '">';
  html += '<br>종료 <input type="datetime-local" name="endTimes" required value="' + defaultDate + '" min="' + minDateTime + '">';
  html += '<br><button type="button" class="remove-btn" onclick="removeSpot(this)">삭제</button>';

  card.innerHTML = html;

  document.getElementById('selectedBox').appendChild(card);
  console.log('카드가 selectedBox에 추가되었습니다');
}


  /* ★★★ 수정된 수동 주소 추가 버튼 이벤트 ★★★ */
  document.getElementById('addByAddressBtn').onclick = function() {
    var addr = document.getElementById('manualAddress').value.trim();
    var placeName = document.getElementById('manualPlaceName').value.trim();
    
    if (!addr) return alert('주소를 입력해주세요.');
    if (!placeName) return alert('장소명을 입력해주세요.');

    if (!kakao || !kakao.maps || !kakao.maps.services || !kakao.maps.services.Geocoder) {
      alert('지도 서비스를 불러오는 중입니다. 잠시 후 다시 시도해주세요.');
      return;
    }

    var geocoder = new kakao.maps.services.Geocoder();
    geocoder.addressSearch(addr, function(result, status) {
      if (status === kakao.maps.services.Status.OK) {
        var loc = {
          name: placeName,
          id: 'MANUAL_' + Date.now(), // ✅ 고유한 ID 생성
          lat: parseFloat(result[0].y),
          lon: parseFloat(result[0].x),
          address: addr,
          isManual: true // ✅ 수동 추가 플래그
        };
        
        console.log('수동 장소 생성:', loc); // 디버깅용
        
        addSpot(loc);
        document.getElementById('manualAddress').value = '';
        document.getElementById('manualPlaceName').value = '';
        alert('주소가 성공적으로 추가되었습니다!');
      } else {
        alert('주소를 찾을 수 없습니다. 정확한 주소를 입력해주세요.');
      }
    });
  };

  /* Enter 키로도 주소 추가 가능하도록 */
  document.getElementById('manualAddress').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
      e.preventDefault();
      document.getElementById('addByAddressBtn').click();
    }
  });
  
  document.getElementById('manualPlaceName').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
      e.preventDefault();
      document.getElementById('addByAddressBtn').click();
    }
  });

  /* ★★★ 수정된 renderPage 함수 ★★★ */
  function renderPage(){
    var kw=document.getElementById('searchInput').value.trim();
    var rid=document.getElementById('region1').value.trim();
    var sid=document.getElementById('region2').value.trim();

    console.log('=== renderPage 호출 ===');
    console.log('현재 탭:', currentType);
    console.log('필터 조건 - 시도:', rid, '시군구:', sid, '키워드:', kw);

    var data=currentType==='accom'?accomList:tourList;
    var nameK=currentType==='accom'?'accomName':'tourName';
    var latK =currentType==='accom'?'accomLat' :'tourLat';
    var lonK =currentType==='accom'?'accomLon' :'tourLon';
    var idK  =currentType==='accom'?'accomId'  :'tourId';

    console.log('전체 데이터 개수:', data.length);

    var filtered=data;
    
    // 시도 필터링
    if(rid) {
      console.log('시도 필터링 시작...');
      filtered=filtered.filter(function(x){
        var dataRegionId = String(x.regionId || '').trim();
        var match = dataRegionId === rid;
        if (!match) {
          console.log('시도 불일치 - 데이터 regionId:', dataRegionId, '조건:', rid, '데이터:', x);
        }
        return match;
      });
      console.log('시도 필터링 후 개수:', filtered.length);
    }
    
    // ★★★ 시군구 필터링 강화 ★★★
    if(sid) {
      console.log('시군구 필터링 시작...');
      console.log('시군구 조건:', sid);
      
      filtered=filtered.filter(function(x){
        var code = getCode(x);
        var match = code === sid;
        
        if (!match) {
          console.log('❌ 시군구 불일치:');
          console.log('  - 데이터:', x);
          console.log('  - 추출된 코드:', code);
          console.log('  - 필터 조건:', sid);
          console.log('  - 타입 비교:', typeof code, 'vs', typeof sid);
        } else {
          console.log('✅ 시군구 일치:', x[nameK], '코드:', code);
        }
        
        return match;
      });
      console.log('시군구 필터링 후 개수:', filtered.length);
    }
    
    // 키워드 필터링
    if(kw) {
      console.log('키워드 필터링 시작...');
      filtered=filtered.filter(function(x){
        var match = x[nameK] && x[nameK].includes(kw);
        return match;
      });
      console.log('키워드 필터링 후 개수:', filtered.length);
    }

    console.log('최종 필터링 결과:', filtered.length);

    var start=(currentPage-1)*itemsPerPage;
    var pageData=filtered.slice(start,start+itemsPerPage);

    var listBox=document.getElementById('listBox'); 
    listBox.innerHTML='';
    
    pageData.forEach(function(loc){
      var lat=loc[latK],lon=loc[lonK];
      if(isNaN(lat)||isNaN(lon)) return;
      var btn=document.createElement('button');
      btn.className='spot-btn'; 
      btn.textContent=loc[nameK];
      btn.onclick=function(){
        addSpot({id:loc[idK],name:loc[nameK],lat:lat,lon:lon});
      };
      listBox.appendChild(btn);
    });

    /* 페이지네이션 */
    var pag=document.getElementById('pagination'); 
    pag.innerHTML='';
    var pageCnt=Math.ceil(filtered.length/itemsPerPage);
    
    if(pageCnt>1){
      if(currentPage>1){
        var prev=document.createElement('button');
        prev.textContent='< 이전'; 
        prev.onclick=function(){currentPage--;renderPage();};
        pag.appendChild(prev);
      }
      var win=5,s=Math.max(1,currentPage-Math.floor(win/2)),
            e=Math.min(pageCnt,s+win-1);
      for(var i=s;i<=e;i++){
        var b=document.createElement('button'); 
        b.textContent=i;
        if(i===currentPage) b.classList.add('active');
        b.onclick=(function(pageNum){
          return function(){currentPage=pageNum;renderPage();};
        })(i);
        pag.appendChild(b);
      }
      if(currentPage<pageCnt){
        var next=document.createElement('button');
        next.textContent='다음 >'; 
        next.onclick=function(){currentPage++;renderPage();};
        pag.appendChild(next);
      }
    }
  }

  /* ★★★ 폼 제출 전 디버깅 강화 ★★★ */
  document.getElementById('scheduleForm').onsubmit = function(e) {
    console.log('=== 폼 제출 데이터 확인 ===');
    var formData = new FormData(this);
    
    // 모든 필드 확인
    var spotIds = formData.getAll('spotIds');
    var isManualArray = formData.getAll('isManual');
    var manualNames = formData.getAll('manualNames');
    var manualAddresses = formData.getAll('manualAddresses');
    var manualLats = formData.getAll('manualLats');
    var manualLons = formData.getAll('manualLons');
    var startTimes = formData.getAll('startTimes');
    var endTimes = formData.getAll('endTimes');
    var dayNos = formData.getAll('dayNos');
    
    console.log('📋 전체 폼 데이터:');
    console.log('spotIds:', spotIds);
    console.log('isManual:', isManualArray);
    console.log('manualNames:', manualNames);
    console.log('manualAddresses:', manualAddresses);
    console.log('manualLats:', manualLats);
    console.log('manualLons:', manualLons);
    console.log('startTimes:', startTimes);
    console.log('endTimes:', endTimes);
    console.log('dayNos:', dayNos);
    
    // 수동 추가된 장소들만 별도 확인
    console.log('🏷️ 수동 추가 장소들:');
    for (var i = 0; i < isManualArray.length; i++) {
      if (isManualArray[i] === 'true') {
        console.log(`Index ${i}: ${manualNames[i]} at ${manualAddresses[i]} (${manualLats[i]}, ${manualLons[i]})`);
      }
    }
    
    // 기본 검증
    if (spotIds.length === 0) {
      alert('최소 하나의 일정을 추가해주세요.');
      e.preventDefault();
      return false;
    }

    for (var i = 0; i < startTimes.length; i++) {
      if (!startTimes[i] || !endTimes[i]) {
        alert('모든 일정의 시작 시간과 종료 시간을 입력해주세요.');
        e.preventDefault();
        return false;
      }
      
      if (new Date(startTimes[i]) >= new Date(endTimes[i])) {
        alert('종료 시간은 시작 시간보다 늦어야 합니다.');
        e.preventDefault();
        return false;
      }
    }
    
    console.log('✅ 폼 검증 통과 - 제출 진행');
    return true;
  };
});
</script>

</body>
</html>


