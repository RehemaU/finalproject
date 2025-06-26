<!-- /WEB-INF/views/schedule/addDetail.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<String> selectedDates = (List<String>)session.getAttribute("selectedDates");
    String listName      = (String)session.getAttribute("listName");
    String calanderListId= (String)session.getAttribute("calanderListId");
    if(selectedDates==null){
        out.println("<script>alert('잘못된 접근입니다.');location.href='"
                    +request.getContextPath()+"/schedule/addList';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=listName%> · 일정 상세 입력</title>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=clusterer"></script>
<style>
  body{font-family:'Noto Sans KR',sans-serif;margin:32px;}
  h2{font-size:26px;margin-bottom:20px;}
  .day-tabs{display:flex;gap:8px;margin-bottom:14px;}
  .day-tab{padding:6px 12px;border-radius:8px;background:#eee;cursor:pointer;}
  .day-tab.active{background:#000;color:#fff;}
  .layout{display:flex;gap:20px;}
  #map{flex:1 1 55%;height:560px;border:1px solid #ccc;border-radius:10px;}
  .right{flex:1 1 40%;display:flex;flex-direction:column;gap:14px;}
  .cat-tabs{display:flex;gap:6px;}
  .cat-tab{flex:1;padding:6px 0;border:1px solid #666;border-radius:8px;cursor:pointer;text-align:center;}
  .cat-tab.active{background:#666;color:#fff;}
  #listBox{border:1px solid #ddd;border-radius:10px;padding:10px;min-height:220px;overflow-y:auto;}
  #selectedBox{border:1px solid #ddd;border-radius:10px;padding:10px;min-height:220px;overflow-y:auto;margin-top:6px;}
  .spot-btn{display:flex;align-items:center;gap:8px;width:100%;text-align:left;padding:6px 8px;margin-bottom:4px;border:1px solid #999;border-radius:6px;background:#fafafa;cursor:pointer;}
  .spot-btn img{width:60px;height:60px;object-fit:cover;border-radius:6px;}    /* ★ 변경 */
  .entry{background:#f7f7f7;border-radius:8px;padding:8px;margin-bottom:6px;font-size:14px;}
  .entry img{width:40px;height:40px;object-fit:cover;border-radius:4px;margin-right:8px;} /* ★ 변경 */
  .entry input[type=datetime-local]{margin:2px 0;}
</style>
</head>
<body>
<h2>🗓 <%=listName%> 일정 추가</h2>

<!-- Day 탭 -->
<div class="day-tabs">
  <c:forEach var="d" items="${selectedDates}" varStatus="s">
    <div class="day-tab ${s.index==0? 'active':''}" data-day="${s.index+1}">
      Day&nbsp;${s.index+1}<br><small>${d}</small>
    </div>
  </c:forEach>
</div>

<div class="layout">
  <div id="map"></div>

  <div class="right">
    <div class="cat-tabs">
      <div class="cat-tab active" data-type="accom">🏨 숙소</div>
      <div class="cat-tab"        data-type="tour">🏛 관광지</div>
    </div>

    <div id="listBox"></div>

    <!-- form 내부에 선택 일정 -->
    <form id="scheduleForm" action="${pageContext.request.contextPath}/schedule/saveDetail" method="post">
      <input type="hidden" name="calanderListId" value="<%=calanderListId%>">

      <h4 style="margin:0;">✍️ 선택 일정</h4>
      <div id="selectedBox"></div>

      <button type="submit" style="margin-top:18px;">💾 저장하기</button>
    </form>
  </div>
</div>

<script>
let currentDayNo = 1, map, accomList=[], tourList=[];

/* Day 탭 */
document.querySelectorAll('.day-tab').forEach(t=>{
  t.onclick=e=>{
    document.querySelectorAll('.day-tab').forEach(x=>x.classList.remove('active'));
    e.currentTarget.classList.add('active');
    currentDayNo = +e.currentTarget.dataset.day;
  };
});

/* 지도 */
kakao.maps.load(()=>{
  map = new kakao.maps.Map(document.getElementById('map'),
        {center:new kakao.maps.LatLng(37.5665,126.9780), level:6});
});

/* 데이터 fetch */
Promise.allSettled([
  fetch('${pageContext.request.contextPath}/admin/accommodation/listAll').then(r=>r.json()),
  fetch('${pageContext.request.contextPath}/admin/tour/listAll').then(r=>r.json())
]).then(([a,t])=>{
  if(a.status==='fulfilled'){ accomList=a.value; renderList('accom'); }
  if(t.status==='fulfilled'){ tourList=t.value; }
});

/* 카테고리 탭 */
document.querySelectorAll('.cat-tab').forEach(t=>{
  t.onclick=e=>{
    document.querySelectorAll('.cat-tab').forEach(x=>x.classList.remove('active'));
    e.currentTarget.classList.add('active');
    renderList(e.currentTarget.dataset.type);
  };
});

/* 목록 렌더링 */
function renderList(type){
  const box=document.getElementById('listBox'); box.innerHTML='';
  const data=(type==='accom')?accomList:tourList;
  data.forEach(loc=>{
    const id   =(type==='accom')?loc.accomId :loc.tourId;
    const name =(type==='accom')?loc.accomName:loc.tourName;
    const lat  =parseFloat((type==='accom')?loc.accomLat:loc.tourLat);
    const lon  =parseFloat((type==='accom')?loc.accomLon:loc.tourLon);
    const img  =(type==='accom')?loc.accomImage:loc.tourImage;            /* ★ 추가 */
    if(isNaN(lat)||isNaN(lon)) return;

    const btn=document.createElement('button');
    btn.type='button';
    btn.className='spot-btn';

    if(img){                                                             /* ★ 추가 */
      const thumb=document.createElement('img');
      thumb.src=img;
      btn.appendChild(thumb);
    }
    btn.appendChild(document.createTextNode(name));                      /* ★ 수정 */

    btn.onclick=()=>addSpot({id,name,lat,lon,image:img});                /* ★ 수정 */
    box.appendChild(btn);
  });
}

/* 장소 선택 */
function addSpot(loc){
  const pos=new kakao.maps.LatLng(loc.lat,loc.lon);
  map.setCenter(pos);
  new kakao.maps.Marker({map,position:pos,title:loc.name});

  const card=document.createElement('div'); card.className='entry';

  const hiddenDay =document.createElement('input');
  hiddenDay.type='hidden'; hiddenDay.name='dayNos[]'; hiddenDay.value=currentDayNo;

  const hiddenSpot=document.createElement('input');
  hiddenSpot.type='hidden'; hiddenSpot.name='spotIds[]'; hiddenSpot.value=loc.id;

  const label=document.createElement('div');                            /* ★ 수정 */
  label.style.display='flex'; label.style.alignItems='center'; label.style.gap='8px'; /* ★ 추가 */

  if(loc.image){                                                        /* ★ 추가 */
    const thumb=document.createElement('img');
    thumb.src=loc.image;
    label.appendChild(thumb);
  }
  const txt=document.createElement('span');
  txt.textContent=`[Day ${currentDayNo}] ${loc.name}`;
  label.appendChild(txt);

  const st=document.createElement('input');
  st.type='datetime-local'; st.required=true; st.className='st';

  const et=document.createElement('input');
  et.type='datetime-local'; et.required=true; et.className='et';

  const hSt=document.createElement('input');
  hSt.type='hidden'; hSt.name='startTimes[]';

  const hEt=document.createElement('input');
  hEt.type='hidden'; hEt.name='endTimes[]';

  card.append(hiddenDay, hiddenSpot, label, document.createElement('br'),
              document.createTextNode('시작 '), st, document.createElement('br'),
              document.createTextNode('종료 '), et, hSt, hEt);

  document.getElementById('selectedBox').appendChild(card);
}

/* submit 검증 & hidden 값 세팅 */
document.getElementById('scheduleForm').addEventListener('submit',e=>{
  const cards=[...document.querySelectorAll('#selectedBox .entry')];
  if(cards.length===0){ alert('⛔ 장소를 선택하세요!'); e.preventDefault(); return; }

  for(const c of cards){
    const st=c.querySelector('.st').value;
    const et=c.querySelector('.et').value;
    if(!st||!et||st>=et){ alert('⛔ 시작/종료 시간을 확인!'); e.preventDefault(); return; }
    c.querySelector('input[name="startTimes[]"]').value=st;
    c.querySelector('input[name="endTimes[]"]').value=et;
  }
});
</script>
</body>
</html>
