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
        <li onclick="selectRegion('${r.regionId}', this)">${r.regionName}</li>
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
  document.querySelectorAll('.category-sidebar li').forEach(li => li.classList.remove('active'));
  element.classList.add('active');

  renderSigunguNav();
}

function renderSigunguNav() {
  const container = document.getElementById('sigunguNav');
  container.innerHTML = '';
  const filtered = sigunguData.filter(s => s.regionId === selectedRegionId);
  filtered.forEach(s => {
    const btn = document.createElement('button');
    btn.textContent = s.sigunguName;
    btn.onclick = () => addCondition(s.regionId, s.sigunguId, s.sigunguName);
    container.appendChild(btn);
  });
}

function addCondition(regionId, sigunguId, label) {
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
window.addEventListener('DOMContentLoaded', () => {
	  fetchFilteredList();   // 전체 관광지 리스트
	  fetchLikedTourIds();   // 찜 상태 동기화
	});
</script>