<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation_editor.jsp" %>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<style>
/* 관광지와 동일한 스타일 */
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #fff;
  margin: 0;
}

.page-wrap {
  max-width: 1480px;
  margin: 0 auto;
  display: flex;
  padding: 40px 20px;
   padding-top: 260px;
}

.category-sidebar {
  width: 200px;
  border-right: 1px solid #eee;
  padding-right: 20px;
}

.category-sidebar h3 {
  font-size: 16px;
  font-weight: 700;
  margin-bottom: 20px;
  border-left: 4px solid #000;
  padding-left: 8px;
}

.category-sidebar ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.category-sidebar li {
  font-size: 14px;
  color: #333;
  padding: 8px 0;
  cursor: pointer;
  transition: 0.2s;
}
.category-sidebar li:hover,
.category-sidebar li.active {
  font-weight: 600;
  color: #000;
}

.content-area {
  flex: 1;
  padding-left: 32px;
}

.sigungu-nav {
  display: flex;
  gap: 16px;
  border-bottom: 1px solid #e5e5e5;
  padding-bottom: 12px;
  margin-bottom: 24px;
  flex-wrap: nowrap;
  overflow-x: auto;
}

.sigungu-nav button {
  background: none;
  border: none;
  font-size: 14px;
  color: #777;
  cursor: pointer;
  padding: 4px 0;
  transition: 0.2s;
}

.sigungu-nav button.active {
  color: #111;
  font-weight: 600;
  border-bottom: 2px solid #000;
}

.selected-conditions {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 24px;
}

.selected-conditions span {
  background: #f5f5f5;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 13px;
  display: flex;
  align-items: center;
}

.selected-conditions span button {
  background: none;
  border: none;
  margin-left: 6px;
  cursor: pointer;
  color: #777;
}
.heart-icon {
  font-family: 'Noto Sans KR', sans-serif;
  font-size: 1.4rem;
  pointer-events: none;
}
</style>

<!-- =========================== ✅ 전체 구조 =========================== -->
<div class="page-wrap">
  <!-- 좌측 시도 카테고리 -->
  <div class="category-sidebar">
    <h3>숙소 지역 필터</h3>
    <ul>
      <c:forEach var="r" items="${regionList}">
        <li data-region-id="${r.regionId}"
    onclick="selectRegion('${r.regionId}', this)">
  ${r.regionName}
</li>

      </c:forEach>
    </ul>
    
  </div>
	
  <!-- 우측 콘텐츠 -->
  <div class="content-area">
  <!-- ✅ 검색창 -->
<div style="margin-bottom: 20px;">
  <input type="text" id="searchInput" placeholder="숙소명을 검색하세요"
         style="padding: 6px 12px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; width: 250px;" />
  <button onclick="applySearch()"
          style="padding: 6px 14px; font-size: 14px; margin-left: 6px; cursor: pointer;">검색</button>
</div>
    <div class="sigungu-nav" id="sigunguNav"></div>
    <div class="selected-conditions" id="conditionList"></div>
    <div id="results"></div>
  </div>
</div>

<!-- =========================== ✅ JS 로직 =========================== -->
<script>
const sigunguData = [
  <c:forEach var="s" items="${sigunguList}" varStatus="loop">
    { regionId: "${s.regionId}", sigunguId: "${s.sigunguId}", sigunguName: "${s.sigunguName}" }<c:if test="${!loop.last}">,</c:if>
  </c:forEach>
];
let searchKeyword = ''; 
let selectedRegionId = '';
const conditions = [];

function applySearch() {
	  const input = document.getElementById('searchInput').value.trim();
	  searchKeyword = input;
	  fetchFilteredList(); // 검색어 반영해서 목록 조회
	}
function selectRegion(regionId, element) {
     selectedRegionId = regionId;
     document.querySelectorAll('.category-sidebar li').forEach(li => li.classList.remove('active'));
     element.classList.add('active');

     // ✅ 조건 배열 초기화 후 region만 조건으로 추가
     conditions.length = 0; // 기존 조건 제거
     conditions.push({ regionId: selectedRegionId, sigunguId: '', label: element.textContent });

     renderConditionList();
     renderSigunguNav();
     fetchFilteredList(); // ✅ 지역만 선택한 상태로 조회
   }

function renderSigunguNav() {
    const container = document.getElementById('sigunguNav');
    container.innerHTML = '';

    const filtered = sigunguData.filter(s => s.regionId === selectedRegionId);

    // ▣ 기본: 한줄, 가로 스크롤
    container.style.flexWrap = "nowrap";
    container.style.overflowX = "auto";

    // ▣ 20개 초과면 2줄 wrap 허용
    if (filtered.length > 20) {
      container.style.flexWrap = "wrap";
      container.style.overflowX = "visible";
    }

    filtered.forEach(s => {
      const btn = document.createElement('button');
      btn.textContent = s.sigunguName;
      btn.onclick = () => addCondition(s.regionId, s.sigunguId, s.sigunguName);
      container.appendChild(btn);
    });
  }

function addCondition(regionId, sigunguId, label) {
     // ✅ 시군구 조건이면 기존 지역-only 조건 제거
     const idx = conditions.findIndex(c => c.regionId === regionId && c.sigunguId === '');
     if (idx !== -1) {
       conditions.splice(idx, 1);
     }

     // 이미 해당 조건이 존재하면 추가 안 함
     if (conditions.some(c => c.regionId === regionId && c.sigunguId === sigunguId)) return;

     conditions.push({ regionId, sigunguId, label });
     renderConditionList();
     fetchFilteredList();
   }


function renderConditionList() {
  const container = document.getElementById('conditionList');
  container.innerHTML = '';
  conditions.forEach((cond, idx) => {
    const tag = document.createElement('span');
    tag.textContent = cond.label;
    const btn = document.createElement('button');
    btn.textContent = '×';
    btn.onclick = () => { conditions.splice(idx, 1); renderConditionList(); fetchFilteredList(); };
    tag.appendChild(btn);
    container.appendChild(tag);
  });
}

function fetchFilteredList(page = 1) {
	  const resultContainer = document.getElementById('results');
	  resultContainer.innerHTML = '로딩 중...';

	  const body = {
	    page: page,
	    sigunguList: conditions,
	    keyword: searchKeyword // ✅ 검색어 포함
	  };

	  fetch('/accomm/filterList', {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/json' },
	    body: JSON.stringify(body)
	  })
	  .then(r => r.text())
	  .then(html => {
	    resultContainer.innerHTML = html;
	    fetchLikedAccommIds(); // 찜 버튼 상태 동기화
	  })
	  .catch(e => {
	    console.error(e);
	    resultContainer.innerHTML = '불러오기 실패';
	  });
	}


let likedAccommIds = [];
function fetchLikedAccommIds() {
  fetch('/like/accommIds')
    .then(r => r.json())
    .then(arr => {
      likedAccommIds = arr;
      updateHeartButtons();
    })
    .catch(e => console.error('찜목록 오류', e));
}

function updateHeartButtons() {
  const set = new Set(likedAccommIds);
  document.querySelectorAll('.heart-btn').forEach(btn => {
    const sid = btn.dataset.accomId;
    const icon = btn.querySelector('.heart-icon');
    if (!icon) return;
    if (set.has(sid)) { btn.classList.add('liked'); icon.textContent = '♥'; }
    else { btn.classList.remove('liked'); icon.textContent = '♡'; }
  });
}

function toggleAccommLike(spotId, btn) {
  if (btn.disabled) return;
  btn.disabled = true;
  const icon = btn.querySelector('.heart-icon');
  const prev = icon.textContent;
  fetch('/like/accomm/toggle', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'spotId=' + encodeURIComponent(spotId)
  })
  .then(r => r.json())
  .then(d => {
    if (!d.success) throw Error('fail');
    if (d.isLiked) {
      btn.classList.add('liked'); icon.textContent = '♥';
      if (!likedAccommIds.includes(spotId)) likedAccommIds.push(spotId);
    } else {
      btn.classList.remove('liked'); icon.textContent = '♡';
      likedAccommIds = likedAccommIds.filter(id => id !== spotId);
    }
  })
  .catch(e => { console.error(e); icon.textContent = prev; })
  .finally(() => { btn.disabled = false; });
}

window.addEventListener('DOMContentLoaded', function () {
     /* 1) URL ?regionId= 파라미터 추출 */
     var params   = new URLSearchParams(location.search);
     var regionId = params.get('regionId');   // 예) /accomm/list?regionId=11

     if (regionId) {
       console.log('[INIT] regionId from URL =', regionId);

       /* 2) 좌측 메뉴에서 같은 regionId 를 가진 li 찾기 */
       var li = document.querySelector(
         '.category-sidebar li[data-region-id="' + regionId + '"]'
       );

       if (li) {
         /* ⓐ 실제 메뉴가 있으면 selectRegion 호출 */
         selectRegion(regionId, li);
         li.scrollIntoView({ block: 'center' });
       } else {
         /* ⓑ 메뉴가 없어도 최소 조건으로 조회 */
         selectedRegionId = regionId;
         conditions.push({ regionId: regionId, sigunguId: '', label: '지역' });
         renderConditionList();
         renderSigunguNav();
         fetchFilteredList();
       }
     } else {
       /* regionId 없이 직접 접속하면 전체 조회 */
       fetchFilteredList();
     }

     /* 3) 찜(좋아요) 동기화 */
     fetchLikedAccommIds();
   });

</script>
