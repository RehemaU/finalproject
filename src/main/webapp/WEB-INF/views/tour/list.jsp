<!-- 무신사 스타일 기반 관광지 필터링 UI 리팩토링 버전 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #fff;
  margin: 0;
}

a {
  text-decoration: none;
  color: inherit;
}

.page-wrap {
  max-width: 1480px;
  margin: 0 auto;
  display: flex;
  padding: 40px 20px;
}

/* 좌측 네비게이션 */
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

/* 우측 콘텐츠 영역 */
.content-area {
  flex: 1;
  padding-left: 32px;
}

/* 시군구 탭 */
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

/* 선택된 조건 */
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
.card-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 40px 32px;
}

.card {
  position: relative;
  overflow: visible;
}

.card-image {
  position: relative;
  z-index: 1;
}

.card-title {
  position: relative;
  z-index: 2;
  background: #fff;
}

.card:hover {
  transform: translateY(-4px);
}

.card-image img,
.card-image .no-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.card-image .no-image {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  font-size: 0.95rem;
  font-weight: 500;
}


.heart-btn{
  position:absolute;
  top:0.75rem;
  right:0.75rem;
  font-size:1.3rem;
  background:none;
  border:none;
  cursor:pointer;
  color:#888;
  transition:color .2s;
  z-index:3;          /* ← 이미지(1), 제목(2)보다 높게 */
}

.heart-btn.liked .heart-icon,
.heart-btn:hover .heart-icon {
  color: #ff4d4f;
}

.heart-icon {
  font-size: 1.4rem;
  pointer-events: none;
}
</style>

<div class="page-wrap">
  <!-- 좌측 시도 카테고리 -->
  <div class="category-sidebar">
    <h3>지역 필터</h3>
    <ul>
      <c:forEach var="r" items="${regionList}">
        <li data-region-id="${r.regionId}"
    onclick="selectRegion('${r.regionId}', this)">
  ${r.regionName}
</li>
      </c:forEach>
    </ul>
  </div>

  <!-- 콘텐츠 영역 -->
  <div class="content-area">
    <!-- 시군구 네비게이션 -->
    <div class="sigungu-nav" id="sigunguNav"></div>

    <!-- 조건 태그 -->
    <div class="selected-conditions" id="conditionList"></div>

    <!-- 관광지 카드 리스트 -->
    <div id="results"></div>
  </div>
</div>

<script>
const sigunguData = [
  <c:forEach var="s" items="${sigunguList}" varStatus="loop">
    { regionId: "${s.regionId}", sigunguId: "${s.sigunguId}", sigunguName: "${s.sigunguName}" }<c:if test="${!loop.last}">,</c:if>
  </c:forEach>
];

let selectedRegionId = '';
const conditions = [];

function selectRegion(regionId, element) {
	  selectedRegionId = regionId;

	  // 사이드바 UI 반영
	  document.querySelectorAll('.category-sidebar li').forEach(li => li.classList.remove('active'));
	  element.classList.add('active');

	  // ✅ 기존 조건 초기화 후 '지역만' 조건 추가
	  conditions.length = 0;
	  conditions.push({ regionId, sigunguId: '', label: element.textContent });

	  renderConditionList();
	  renderSigunguNav();
	  fetchFilteredList(); // 지역만 조건으로 조회
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
	  // ✅ 지역-only 조건 제거 (같은 지역의 시군구를 누르면)
	  const idx = conditions.findIndex(c => c.regionId === regionId && c.sigunguId === '');
	  if (idx !== -1) {
	    conditions.splice(idx, 1);
	  }

	  // ✅ 이미 같은 조건이 있으면 추가하지 않음
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

function fetchFilteredList() {
  const resultContainer = document.getElementById('results');
  resultContainer.innerHTML = '로딩 중...';

  fetch('/tour/filterList', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(conditions)
  })
  .then(r => r.text())
  .then(html => {
    resultContainer.innerHTML = html;
    fetchLikedTourIds();
  })
  .catch(e => {
    console.error(e);
    resultContainer.innerHTML = '불러오기 실패';
  });
}

function norm(id) { return String(id ?? '').trim().toUpperCase(); }
let likedTourIds = [];
function fetchLikedTourIds() {
  fetch('/like/spotIds')
    .then(r => r.json())
    .then(arr => {
      console.log('[찜 리스트 원본]', arr);  // ← 원본 응답 찍기
		
      likedTourIds = (Array.isArray(arr) ? arr : [])
        .map(item => typeof item === 'object'
              ? norm(item.spotId || item.SPOT_ID)
              : norm(item));

      console.log('[찜 리스트 정규화된 ID]', likedTourIds); // ← 실제 비교에 쓰이는 배열 확인

      updateHeartButtons();
    })
    .catch(e => console.error('찜목록 오류', e));
}
function updateHeartButtons() {
  const set = new Set(likedTourIds);
  document.querySelectorAll('.heart-btn').forEach(btn => {
    const sid = norm(btn.dataset.spotId);
    const icon = btn.querySelector('.heart-icon');
    if (!icon) return;
    
    console.log('updateHeartButtons() 실행됨');
    console.log('찜 ID 목록:', likedTourIds);
    
    if (set.has(sid)) { btn.classList.add('liked'); icon.textContent = '♥'; }
    else { btn.classList.remove('liked'); icon.textContent = '♡'; }
  });
}
function toggleLike(spotId, btn) {
  if (btn.disabled) return;
  btn.disabled = true;
  const icon = btn.querySelector('.heart-icon');
  const prev = icon.textContent;
  const nId = norm(spotId);
  fetch('/like/toggle', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'spotId=' + encodeURIComponent(spotId)
  })
  .then(r => r.json())
  .then(d => {
    if (!d.success) throw Error('fail');
    if (d.isLiked) {
      btn.classList.add('liked'); icon.textContent = '♥';
      if (!likedTourIds.includes(nId)) likedTourIds.push(nId);
    } else {
      btn.classList.remove('liked'); icon.textContent = '♡';
      likedTourIds = likedTourIds.filter(id => id !== nId);
    }
  })
  .catch(e => { console.error(e); icon.textContent = prev; })
  .finally(() => { btn.disabled = false; });
}
window.addEventListener('DOMContentLoaded', function () {
	  // 1) URL 쿼리에서 regionId 추출
	  var params    = new URLSearchParams(location.search);
	  var regionId  = params.get('regionId');   // 예) /tour/list?regionId=11

	  if (regionId) {
	    console.log('[INIT] regionId from URL =', regionId);

	    // 2) 좌측 사이드바에서 동일 regionId li 찾기
	    var li = document.querySelector(
	      '.category-sidebar li[data-region-id="' + regionId + '"]'
	    );

	    if (li) {
	      // ⓐ 정상적으로 메뉴가 있으면 해당 지역 선택
	      selectRegion(regionId, li);
	      li.scrollIntoView({ block: 'center' });
	    } else {
	      // ⓑ 메뉴에 없더라도 최소 조건으로 조회
	      selectedRegionId = regionId;
	      conditions.push({ regionId: regionId, sigunguId: '', label: '지역' });
	      renderConditionList();
	      renderSigunguNav();
	      fetchFilteredList();
	    }
	  } else {
	    // regionId 파라미터가 없으면 전체 리스트
	    fetchFilteredList();
	  }

	  // 3) 찜 상태 동기화
	  fetchLikedTourIds();
	});

</script>