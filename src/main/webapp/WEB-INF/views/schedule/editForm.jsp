<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
  /* ─ JSP 상단에서 세션 값 꺼냄 ─ */
  String listName       = (String) session.getAttribute("listName");
  String calanderListId = (String) session.getAttribute("calanderListId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%= listName %> · 일정 수정</title>

<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">

<!-- Kakao Map -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=clusterer"></script>

<!-- ▸ CSS (addDetail 와 동일 + 삭제버튼) -->
<style>
:root{
  --bd:#e4e4e4; --bg:#fdfdfd; --subbg:#fafafa;
  --pill:#f1f1f1; --txt:#111; --radius:14px
}
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Pretendard','Inter',sans-serif;background:var(--bg);color:var(--txt)}
h2{font-size:28px;font-weight:700;padding:32px 48px 4px;white-space:nowrap}
.page-wrap{display:flex;height:calc(100vh - 96px)}

.sidebar,.plan-panel{
  width:360px;min-width:360px;background:var(--subbg);
  border-right:1px solid var(--bd);padding:26px 24px;overflow-y:auto
}
.plan-panel{background:#fff}
#map{flex:1 1 0%}

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

/* ─ 선택 일정 패널 ─ */
.plan-panel h3{font-size:18px;font-weight:700;margin-bottom:16px}
#selectedBox{
  max-height:calc(100vh - 270px);overflow-y:auto;display:flex;flex-direction:column;gap:10px;
  border:1px solid var(--bd);border-radius:var(--radius);padding:12px;background:var(--subbg)
}
.entry{
  border:1px solid var(--bd);border-radius:12px;padding:12px 14px;background:#fff;position:relative
}
.entry strong{display:block;margin-bottom:6px;font-weight:600}
.entry input[type=datetime-local]{
  width:100%;padding:8px;border:1px solid var(--bd);border-radius:8px;font-size:13px;margin-top:4px
}
/* 삭제 버튼 */
.del-btn{
  position:absolute;top:8px;right:10px;border:none;background:none;cursor:pointer;color:#d33;font-size:17px
}
.del-btn:hover{color:#f55}

#scheduleForm{display:flex;flex-direction:column;gap:14px}
#scheduleForm button[type=submit]{
  all:unset;width:100%;padding:14px 0;border-radius:var(--radius);
  background:#000;color:#fff;font-weight:600;text-align:center;cursor:pointer
}
#scheduleForm button[type=submit]:hover{background:#222}

@media(max-width:900px){
  .page-wrap{flex-direction:column}
  .sidebar,.plan-panel{width:100%;min-width:0;border-right:0;border-bottom:1px solid var(--bd)}
  #map{height:58vh}
}
</style>
</head>

<body>
<h2><c:out value="${listName}"/> <small style="font-size:16px;color:#666">(수정)</small></h2>

<div class="page-wrap">
  <!-- ▸ 왼쪽 : 장소 검색 -->
  <aside class="sidebar">
    <!-- 날짜 탭 -->
    <div class="day-tabs">
      <c:set var="maxDay" value="0"/>
      <c:forEach var="c" items="${calList}">
        <c:if test="${c.calDayNo > maxDay}"><c:set var="maxDay" value="${c.calDayNo}"/></c:if>
      </c:forEach>
      <c:forEach begin="1" end="${maxDay}" var="d" varStatus="s">
        <div class="day-tab ${s.index==0?'active':''}" data-day="${d}">Day ${d}</div>
      </c:forEach>
    </div>

    <!-- 카테고리 탭 -->
    <div class="cat-tabs">
      <div class="cat-tab active" data-type="accom">숙소</div>
      <div class="cat-tab"        data-type="tour">관광지</div>
    </div>

    <!-- 지역/검색 -->
    <select id="region1" onchange="updateSigunguOptions()">
      <option value="">시·도 선택</option>
      <c:forEach var="r" items="${regionList}">
        <option value="${r.regionId}">${r.regionName}</option>
      </c:forEach>
    </select>

    <select id="region2"><option value="">시·군·구 선택</option></select>
    <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
    <button class="filter-btn" id="applyFilterBtn">조회</button>

    <!-- 검색 결과 & 페이지네이션 -->
    <div id="listBox"></div>
    <div id="pagination"></div>
  </aside>

  <!-- ▸ 오른쪽 : 기존 일정 + 수정 -->
  <aside class="plan-panel">
    <h3>선택 일정</h3>
    <form id="scheduleForm" action="${pageContext.request.contextPath}/schedule/updateDetail" method="post">
      <input type="hidden" name="calanderListId" value="<%=calanderListId%>">
      <div id="selectedBox">
        <!-- 서버에서 받은 calList 미리 렌더 -->
        <c:forEach var="c" items="${calList}">
          <div class="entry">
            <button type="button" class="del-btn" onclick="this.parentElement.remove()">🗑</button>

            <input type="hidden" name="calanderIds" value="${c.calanderId}">
            <input type="hidden" name="dayNos"      value="${c.calDayNo}">
            <input type="hidden" name="spotIds"     value="${c.spotId}">

            <strong>[Day ${c.calDayNo}] ${c.locationName}</strong>
            시작 <input type="datetime-local" name="startTimes"
                        value="${fn:replace(c.calanderStartTime,' ','T')}" required>
            종료 <input type="datetime-local" name="endTimes"
                        value="${fn:replace(c.calanderEndTime,' ','T')}" required>
          </div>
        </c:forEach>
      </div>
      <button type="submit">변경 사항 저장</button>
    </form>
  </aside>

  <!-- ▸ 지도 -->
  <div id="map"></div>
</div>

<!-- ▸ JS : 시·군·구 데이터 주입 -->
<script>
const sigunguData=[];
<c:forEach var="s" items="${sigunguList}">
sigunguData.push({regionId:"${fn:trim(s.regionId)}",sigunguId:"${fn:trim(s.sigunguId)}",
                  sigunguName:"${fn:escapeXml(s.sigunguName)}"});
</c:forEach>
function updateSigunguOptions(){
  const rId=document.getElementById('region1').value;
  const region2=document.getElementById('region2');
  region2.innerHTML='<option value="">시·군·구 선택</option>';
  sigunguData.filter(s=>s.regionId===rId).forEach(s=>{
    const opt=document.createElement('option');
    opt.value=s.sigunguId;opt.textContent=s.sigunguName;region2.appendChild(opt);
  });
}
</script>

<!-- ▸ JS : 검색·추가(기존 addDetail 코드 그대로) -->
<script>
document.addEventListener('DOMContentLoaded',()=>{
  let currentDayNo=1,currentType='accom',currentPage=1,itemsPerPage=6,
      map,accomList=[],tourList=[];
  const getCode=obj=>String(obj.sigunguCode??obj.sigunguId??obj.sigungu_id??'').trim();

  // Day 탭
  document.querySelectorAll('.day-tab').forEach(t=>t.onclick=e=>{
    document.querySelectorAll('.day-tab').forEach(x=>x.classList.remove('active'));
    e.currentTarget.classList.add('active');currentDayNo=+e.currentTarget.dataset.day;
  });
  // 카테고리 탭
  document.querySelectorAll('.cat-tab').forEach(t=>t.onclick=e=>{
    document.querySelectorAll('.cat-tab').forEach(x=>x.classList.remove('active'));
    e.currentTarget.classList.add('active');currentType=e.currentTarget.dataset.type;
    currentPage=1;renderPage();
  });

  // Kakao 지도
  kakao.maps.load(()=>{
    map=new kakao.maps.Map(document.getElementById('map'),{
      center:new kakao.maps.LatLng(37.5665,126.9780),level:6
    });
  });

  // 데이터 fetch
  Promise.all([
    fetch('${pageContext.request.contextPath}/accommodation/listAll').then(r=>r.json()),
    fetch('${pageContext.request.contextPath}/admin/listAll').then(r=>r.json())
  ]).then(([a,t])=>{
    accomList=a.map(o=>({...o,accomLat:+o.accomLat,accomLon:+o.accomLon}));
    tourList =t.map(o=>({...o,tourLat:+o.tourLat ,tourLon :+o.tourLon }));
    renderPage();
  }).catch(console.error);

  // 필터
  document.getElementById('applyFilterBtn').onclick=()=>{currentPage=1;renderPage();}
  document.getElementById('searchInput').addEventListener('keydown',e=>{
    if(e.key==='Enter'){e.preventDefault();document.getElementById('applyFilterBtn').click();}
  });

  // 목록 렌더 함수
  function renderPage(){
    const kw=document.getElementById('searchInput').value.trim();
    const rid=document.getElementById('region1').value.trim();
    const sid=document.getElementById('region2').value.trim();

    const data=currentType==='accom'?accomList:tourList;
    const nameK=currentType==='accom'?'accomName':'tourName';
    const latK =currentType==='accom'?'accomLat' :'tourLat';
    const lonK =currentType==='accom'?'accomLon' :'tourLon';
    const idK  =currentType==='accom'?'accomId'  :'tourId';

    let filtered=data;
    if(rid) filtered=filtered.filter(x=>String(x.regionId).trim()===rid);
    if(sid) filtered=filtered.filter(x=>getCode(x)===sid);
    if(kw)  filtered=filtered.filter(x=>x[nameK]?.includes(kw));

    const listBox=document.getElementById('listBox');listBox.innerHTML='';
    filtered.slice((currentPage-1)*itemsPerPage,currentPage*itemsPerPage)
            .forEach(loc=>{
              const lat=loc[latK],lon=loc[lonK];
              if(isNaN(lat)||isNaN(lon)) return;
              const btn=document.createElement('button');
              btn.className='spot-btn';btn.textContent=loc[nameK];
              btn.onclick=()=>addSpot({id:loc[idK],name:loc[nameK],lat,lon});
              listBox.appendChild(btn);
            });

    // 페이지네이션
    const pag=document.getElementById('pagination');pag.innerHTML='';
    const totalPages=Math.ceil(filtered.length/itemsPerPage);
    if(totalPages>1){
      if(currentPage>1){
        const prev=document.createElement('button');
        prev.textContent='< 이전';prev.onclick=()=>{currentPage--;renderPage();};
        pag.appendChild(prev);
      }
      const win=5,s=Math.max(1,currentPage-Math.floor(win/2)),
            e=Math.min(totalPages,s+win-1);
      for(let i=s;i<=e;i++){
        const b=document.createElement('button');b.textContent=i;
        if(i===currentPage) b.classList.add('active');
        b.onclick=()=>{currentPage=i;renderPage();};pag.appendChild(b);
      }
      if(currentPage<totalPages){
        const next=document.createElement('button');
        next.textContent='다음 >';next.onclick=()=>{currentPage++;renderPage();};
        pag.appendChild(next);
      }
    }
  }

  // Spot 추가
  function addSpot(loc){
    const pos=new kakao.maps.LatLng(loc.lat,loc.lon);
    map.setCenter(pos);
    new kakao.maps.Marker({map,position:pos,title:loc.name});

    const card=document.createElement('div');card.className='entry';
    card.innerHTML=
      '<button type="button" class="del-btn" onclick="this.parentElement.remove()">🗑</button>'+
      '<input type="hidden" name="calanderIds" value="">'+     /* 새로 추가된 항목: ID 없음 */
      '<input type="hidden" name="dayNos" value="'+currentDayNo+'">'+
      '<input type="hidden" name="spotIds" value="'+loc.id+'">'+
      '<strong>[Day '+currentDayNo+'] '+loc.name+'</strong>'+
      '시작 <input type="datetime-local" name="startTimes" required>'+
      '종료 <input type="datetime-local" name="endTimes" required>';
    document.getElementById('selectedBox').appendChild(card);
  }
});
</script>
</body>
</html>
