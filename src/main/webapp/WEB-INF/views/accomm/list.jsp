<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<jsp:include page="/WEB-INF/views/include/navigation.jsp" />

<!-- 조건 선택 영역 -->
<div class="filter-container p-4 bg-white shadow rounded mb-6">
  <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
    <!-- 시/도 필터 -->
    <div>
      <label for="region1" class="block font-medium">시·도 선택</label>
      <select id="region1" class="w-full border rounded px-2 py-1" onchange="updateSigunguOptions()">
        <option value="">시·도 선택</option>
        <c:forEach var="r" items="${regionList}">
          <option value="${r.regionId}">${r.regionName}</option>
        </c:forEach>
      </select>
    </div>
    <!-- 시/군/구 필터 -->
    <div>
      <label for="region2" class="block font-medium">시·군·구 선택</label>
      <select id="region2" class="w-full border rounded px-2 py-1">
        <option value="">전체</option>
      </select>
    </div>

    <!-- 선택된 조건 리스트 -->
    <div class="col-span-2">
      <label class="block font-medium mb-1" for="conditionList">지역</label>
      <div id="conditionList" class="flex flex-wrap gap-2"></div>
    </div>
  </div>

  <div class="mt-4 flex items-center space-x-2">
    <button type="button" class="px-4 py-2 bg-blue-600 text-white rounded" onclick="addCondition()">+ 조건 추가</button>
  </div>
</div>

<!-- 카드 리스트 영역 -->
<div id="results">
  <%@ include file="/WEB-INF/views/accomm/cardList.jsp" %>
</div>

<!-- JavaScript -->
<script>
  // 지역과 시군구 데이터
  const sigunguData = [
    <c:forEach var="s" items="${sigunguList}" varStatus="status">
      {
        regionId: "${s.regionId}",
        sigunguId: "${s.sigunguId}",
        sigunguName: "${s.sigunguName}"
      }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];

  // 지역 선택시 시군구 옵션 업데이트
  function updateSigunguOptions() {
    const regionId = document.getElementById('region1').value;
    const region2 = document.getElementById('region2');
    region2.innerHTML = '<option value="">전체</option>';

    const filtered = sigunguData.filter(s => s.regionId === regionId);
    filtered.forEach(s => {
      const opt = document.createElement('option');
      opt.value = s.sigunguId;
      opt.text = s.sigunguName;
      region2.appendChild(opt);
    });

    // 자동으로 첫 번째 유효 항목 선택 (원하면 주석 제거)
    // if (filtered.length > 0) region2.selectedIndex = 1;
  }

  const conditions = [];
  document.addEventListener("DOMContentLoaded", function() {
	    // 페이지 로딩 시, 조건이 없을 경우 모든 숙소를 가져오기 위해 fetchFilteredList() 호출
	    fetchFilteredList();
	});
  // 조건 추가 함수
function addCondition() {
    const region1 = document.getElementById('region1');
    const region2 = document.getElementById('region2');

    const regionId = region1.value;  // 선택된 regionId
    const sigunguId = region2.value; // 선택된 sigunguId

    // 선택 안 했을 경우 방지
    if (!regionId || !sigunguId) {
      alert("시·도와 시·군·구를 모두 선택해주세요.");
      return;
    }

    // 선택된 시·도 이름과 시·군·구 이름을 가져오기
    const regionName = region1.options[region1.selectedIndex]?.text || '';  // 이미 선택된 시·도 이름
    const sigunguName = region2.options[region2.selectedIndex]?.text || '';  // 이미 선택된 시·군·구 이름

    // 디버깅: 선택된 값이 제대로 가져오는지 확인
    console.log("선택된 시·도 이름:", regionName);  // regionName 출력
    console.log("선택된 시·군·구 이름:", sigunguName);  // sigunguName 출력

    // 시·도 또는 시·군·구 이름이 비어 있을 경우 경고
    if (!regionName || !sigunguName) {
        console.warn("조건이 비어있습니다. regionName:", regionName, "sigunguName:", sigunguName);
        alert("올바른 조건을 선택해주세요.");
        return;
    }

    // 라벨 생성 (trim 없이 바로 결합)
    const label = regionName + ' ' + sigunguName;

    // 라벨 생성 후, 콘솔로 확인
    console.log("추가될 조건 라벨:", label); // 라벨 출력

    // 라벨이 비어있을 경우 처리
    if (!label || label.length === 0) {
        alert("올바른 조건을 선택해주세요.");
        console.warn("빈 라벨:", label); // 빈 라벨 경고
        return;
    }

    // 이미 추가된 조건인지 체크
    const exists = conditions.some(c => c.sigunguId === sigunguId && c.regionId === regionId);
    if (exists) {
      alert("이미 추가된 조건입니다.");
      return;
    }

    // 조건 추가
    conditions.push({ regionId, sigunguId, label });
    renderConditionList();
    fetchFilteredList();
}



  // 조건 리스트 렌더링
  function renderConditionList() {
    const container = document.getElementById('conditionList');
    container.innerHTML = '';

    conditions.forEach((cond, idx) => {
      console.log("조건 라벨:", cond.label); // 조건 라벨 확인

      const tag = document.createElement('span');
      tag.setAttribute("style", `
        display:inline-flex;
        align-items:center;
        background-color:#e5e7eb;
        font-size:14px;
        color:#111;
        white-space:nowrap;
        padding:4px 10px;
        border-radius:9999px;
        margin-right:8px;
        margin-bottom:8px;
      `);

      // 라벨이 비어있으면 경고 출력
      if (!cond.label) {
        console.warn('조건 라벨이 비어있음:', cond);
      }

      tag.appendChild(document.createTextNode(cond.label || '알 수 없음'));

      const btn = document.createElement('button');
      btn.textContent = '×';
      btn.setAttribute("style", "margin-left:8px; color:#6b7280; cursor:pointer;");
      btn.onclick = () => removeCondition(idx);

      tag.appendChild(btn);
      container.appendChild(tag);
    });
  }

  // 조건 제거
  function removeCondition(index) {
    conditions.splice(index, 1);
    renderConditionList();
    fetchFilteredList();
  }

  // 필터링된 리스트 가져오기
  function fetchFilteredList() {
    const resultContainer = document.getElementById('results');
    resultContainer.innerHTML = '로딩 중...';

    fetch('/accomm/filterList', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(conditions)
    })
    .then(res => res.text())
    .then(html => {
      resultContainer.innerHTML = html;
    })
    .catch(err => {
      resultContainer.innerHTML = '<div class="text-red-500">조건 불러오기 실패</div>';
      console.error(err);
    });
  }
</script>
