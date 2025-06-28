<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<String> selectedDates = (List<String>) session.getAttribute("selectedDates");
    String listName       = (String) session.getAttribute("listName");
    String calanderListId = (String) session.getAttribute("calanderListId");
    if (selectedDates == null) {
        out.println("<script>alert('잘못된 접근입니다.');location.href='"
                    + request.getContextPath() + "/schedule/addList';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title><%= listName %> · 일정 상세 입력</title>

<!-- ▼ Kakao Map -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=clusterer"></script>

<!-- ▼ Pretendard + Inter -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">

<!-- ★★★ style 교체판 ★★★ -->
<style>
:root{--txt:#111;--sub:#767676;--bg:#fdfdfd;--bg-light:#fafafa;
      --bd:#e4e4e4;--pill:#f1f1f1;--accent:#000;--radius:14px;font-size:15px}
*{margin:0;padding:0;box-sizing:border-box}

body{font-family:'Pretendard','Inter',sans-serif;color:var(--txt);background:var(--bg)}
h2{font-family:'Inter',sans-serif;font-size:28px;font-weight:700;letter-spacing:-.02em}

.page-wrap{display:flex;height:calc(100vh - 96px)}
.sidebar{flex:0 0 360px;max-width:360px;background:var(--bg-light);border-right:1px solid var(--bd);
         padding:26px 24px;overflow-y:auto}
#map{flex:1 1 0%;min-width:0}

.day-tabs,.cat-tabs{display:flex;gap:12px;margin-bottom:22px}
.day-tab,.cat-tab{flex:1;padding:10px 0;border-radius:var(--radius);background:var(--pill);
                  color:var(--txt);font-weight:600;text-align:center;cursor:pointer;transition:.25s}
.day-tab.active,.cat-tab.active{background:var(--accent);color:#fff}

#searchInput{width:100%;padding:11px 14px;border:1px solid var(--bd);border-radius:var(--radius);
             background:#fff;font-size:14px;margin-bottom:20px;transition:border-color .2s}
#searchInput:focus{outline:none;border-color:var(--accent)}

#listBox{display:flex;flex-direction:column;gap:12px;max-height:260px;overflow-y:auto;counter-reset:item}
.spot-btn{all:unset;display:flex;align-items:center;gap:14px;border:1px solid var(--bd);background:#fff;
          border-radius:var(--radius);padding:14px 16px;cursor:pointer;transition:box-shadow .25s,transform .25s}
.spot-btn:hover{box-shadow:0 6px 14px rgba(0,0,0,.06);transform:translateY(-2px)}
.spot-btn::before{counter-increment:item;content:counter(item);flex:0 0 26px;height:26px;border-radius:50%;
                  background:var(--accent);color:#fff;font:600 13px/26px 'Inter',sans-serif;text-align:center}

#pagination{display:flex;justify-content:center;gap:10px;margin-top:16px;flex-wrap:wrap}
#pagination button{all:unset;min-width:34px;padding:6px 0;border:1px solid var(--bd);border-radius:10px;
                   text-align:center;cursor:pointer;font-size:13px;transition:.2s}
#pagination button:hover,#pagination button.active{background:var(--accent);color:#fff;border-color:var(--accent)}

.day-section{margin-bottom:20px;padding:16px;background:#fff;border:1px solid var(--bd);border-radius:var(--radius)}
.day-section>h5{margin-bottom:10px;font-size:15px;font-weight:700}
.entry{border:1px solid var(--bd);border-radius:12px;padding:12px 14px;background:var(--bg-light);margin-bottom:10px}
.entry strong{font-weight:600;display:block;margin-bottom:6px}
.entry input[type=datetime-local]{width:100%;padding:8px;border:1px solid var(--bd);border-radius:8px;
                                  background:#fff;font-size:13px;margin:4px 0}

#scheduleForm button[type=submit]{all:unset;width:100%;margin-top:14px;padding:14px 0;
                                  background:var(--accent);color:#fff;font-weight:600;text-align:center;
                                  border-radius:var(--radius);cursor:pointer}
#scheduleForm button:hover{background:#222}

@media(max-width:860px){
  .page-wrap{flex-direction:column}
  .sidebar{flex:none;max-width:none;border-right:0;border-bottom:1px solid var(--bd)}
  #map{height:58vh}
}
</style>
<!-- ★★★ style 끝 ★★★ -->
</head>

<!-- ───────────── 이하 모든 HTML·JS 로직은 기존 코드 그대로 ───────────── -->
<body>

<div style="padding:32px 48px 4px"><h2><c:out value="${listName}"/></h2></div>

<div class="page-wrap">
  <aside class="sidebar">
    <!-- Day Tabs -->
    <div class="day-tabs">
      <c:forEach var="d" items="${selectedDates}" varStatus="s">
        <div class="day-tab ${s.index==0?'active':''}" data-day="${s.index+1}">day${s.index+1}</div>
      </c:forEach>
    </div>

    <!-- Category Tabs -->
    <div class="cat-tabs">
      <div class="cat-tab active" data-type="accom">숙소</div>
      <div class="cat-tab"        data-type="tour">관광지</div>
    </div>

    <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
    <div id="listBox"></div>
    <div id="pagination"></div>

    <form id="scheduleForm" action="${pageContext.request.contextPath}/schedule/saveDetail" method="post" style="margin-top:18px">
      <input type="hidden" name="calanderListId" value="<%= calanderListId %>">
      <h4 style="margin:0 0 8px 0;">선택 일정</h4>
      <div id="selectedBox"></div>
      <button type="submit">일정 저장하기</button>
    </form>
  </aside>

  <div id="map"></div>
</div>

<!-- JS -- 그대로 유지 (생략) -->
<script>
let currentDayNo = 1, map, accomList = [], tourList = [], currentPage = 1, itemsPerPage = 6;

[...document.querySelectorAll('.day-tab')].forEach(t => t.onclick = e => {
  document.querySelectorAll('.day-tab').forEach(x => x.classList.remove('active'));
  e.currentTarget.classList.add('active');
  currentDayNo = +e.currentTarget.dataset.day;
});

kakao.maps.load(() => {
  map = new kakao.maps.Map(document.getElementById('map'), {
    center: new kakao.maps.LatLng(37.5665,126.9780), level: 6
  });
});

Promise.allSettled([
  fetch('${pageContext.request.contextPath}/accomm/accommodation/listAll').then(r => r.json()),
  fetch('${pageContext.request.contextPath}/admin/listAll').then(r => r.json())
]).then(([a, t]) => {
  if (a.status === 'fulfilled') { accomList = a.value; renderPage('accom'); }
  if (t.status === 'fulfilled') { tourList  = t.value; }
});

[...document.querySelectorAll('.cat-tab')].forEach(t => t.onclick = e => {
  document.querySelectorAll('.cat-tab').forEach(x => x.classList.remove('active'));
  e.currentTarget.classList.add('active');
  currentPage = 1;
  const keyword = document.getElementById('searchInput').value.trim();
  renderPage(e.currentTarget.dataset.type, keyword);
});

function renderPage(type, keyword = '') {
  const box = document.getElementById('listBox'); box.innerHTML = '';
  const data = type === 'accom' ? accomList : tourList;
  const filtered = keyword 
    ? data.filter(loc => {
        const name = type === 'accom' ? loc.accomName : loc.tourName;
        return name.includes(keyword);
      }) 
    : data;
  const start = (currentPage - 1) * itemsPerPage;
  const end = start + itemsPerPage;
  filtered.slice(start, end).forEach(loc => {
    const id = type === 'accom' ? loc.accomId : loc.tourId;
    const name = type === 'accom' ? loc.accomName : loc.tourName;
    const lat = parseFloat(type === 'accom' ? loc.accomLat : loc.tourLat);
    const lon = parseFloat(type === 'accom' ? loc.accomLon : loc.tourLon);
    if (isNaN(lat) || isNaN(lon)) return;
    const btn = document.createElement('button');
    btn.type = 'button'; btn.className = 'spot-btn'; btn.textContent = name;
    btn.onclick = () => addSpot({id, name, lat, lon});
    box.appendChild(btn);
  });
  renderPagination(Math.ceil(filtered.length / itemsPerPage), type, keyword);
}

function renderPagination(pageCount, type, keyword = '') {
  const box = document.getElementById('pagination'); box.innerHTML = '';
  const maxPageLinks = 5;
  const startPage = Math.max(1, currentPage - Math.floor(maxPageLinks / 2));
  const endPage = Math.min(pageCount, startPage + maxPageLinks - 1);
  const realStartPage = Math.max(1, endPage - maxPageLinks + 1);

  if (currentPage > 1) {
    const prev = document.createElement('button');
    prev.textContent = '< 이전';
    prev.onclick = () => { currentPage--; renderPage(type, keyword); };
    box.appendChild(prev);
  }
  for (let i = realStartPage; i <= endPage; i++) {
    const btn = document.createElement('button');
    btn.textContent = i;
    if (i === currentPage) btn.classList.add('active');
    btn.onclick = () => { currentPage = i; renderPage(type, keyword); };
    box.appendChild(btn);
  }
  if (currentPage < pageCount) {
    const next = document.createElement('button');
    next.textContent = '다음 >';
    next.onclick = () => { currentPage++; renderPage(type, keyword); };
    box.appendChild(next);
  }
}

// ✅ 검색 이벤트
document.getElementById('searchInput').addEventListener('input', e => {
  const keyword = e.target.value.trim();
  const currentType = document.querySelector('.cat-tab.active').dataset.type;
  currentPage = 1;
  renderPage(currentType, keyword);
});

function addSpot(loc) {
  const pos = new kakao.maps.LatLng(loc.lat, loc.lon);
  map.setCenter(pos);
  new kakao.maps.Marker({map, position: pos, title: loc.name});
  const card = document.createElement('div'); card.className = 'entry';
  const hiddenDay  = document.createElement('input'); hiddenDay.type  = 'hidden'; hiddenDay.name  = 'dayNos';   hiddenDay.value  = currentDayNo;
  const hiddenSpot = document.createElement('input'); hiddenSpot.type = 'hidden'; hiddenSpot.name = 'spotIds';  hiddenSpot.value = loc.id;
  const label = document.createElement('strong'); label.textContent = `[Day ${currentDayNo}] ${loc.name}`;
  const st = document.createElement('input'); st.type = 'datetime-local'; st.required = true; st.className = 'st';
  const et = document.createElement('input'); et.type = 'datetime-local'; et.required = true; et.className = 'et';
  const hSt = document.createElement('input'); hSt.type = 'hidden'; hSt.name = 'startTimes';
  const hEt = document.createElement('input'); hEt.type = 'hidden'; hEt.name = 'endTimes';
  card.append(hiddenDay, hiddenSpot, label, document.createElement('br'),
              document.createTextNode('시작 '), st, document.createElement('br'),
              document.createTextNode('종료 '), et, hSt, hEt);
  document.getElementById('selectedBox').appendChild(card);
}

document.getElementById('scheduleForm').addEventListener('submit', e => {
  const cards = [...document.querySelectorAll('#selectedBox .entry')];
  if (cards.length === 0) { alert('⛔ 장소를 선택하세요!'); e.preventDefault(); return; }
  for (const c of cards) {
    const st = c.querySelector('.st').value;
    const et = c.querySelector('.et').value;
    if (!st || !et || st >= et) { alert('⛔ 시작/종료 시간을 확인!'); e.preventDefault(); return; }
    c.querySelector('input[name="startTimes"]').value = st;
    c.querySelector('input[name="endTimes"]').value   = et;
  }
});</script>
</body>
</html>
