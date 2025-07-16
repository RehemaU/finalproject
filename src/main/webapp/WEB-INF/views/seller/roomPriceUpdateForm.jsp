<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/include/sellerHead.jsp" %>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>객실 요금 수정</title>
  <style>
    .container { width: 800px; margin: 30px auto; font-family: sans-serif; }
    .form-row { margin-bottom: 20px; }
    .form-row label { display: inline-block; width: 120px; font-weight: bold; }
    select, input[type="date"], input[type="number"] {
      padding: 6px; width: 200px;
    }
    table {
      width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 14px;
    }
    table th, table td {
      border: 1px solid #ccc; padding: 10px; text-align: center;
    }
    thead { background-color: #f0f0f0; }
    #noPriceMsg { text-align: center; color: #888; margin-top: 20px; }
    button {
      padding: 8px 20px; background-color: #3478f6; color: white;
      border: none; border-radius: 6px; font-size: 14px; cursor: pointer;
    }
    button:hover { background-color: #2d64c7; }
  </style>
</head>
<body>
<div class="container">
  <h2>객실 요금 수정</h2>

  <!-- 객실 선택 -->
  <div class="form-row">
    <label for="roomIdSelect">객실 선택</label>
    <select id="roomIdSelect">
      <option value="">객실을 선택하세요</option>
      <c:forEach var="room" items="${roomList}">
        <option value="${room.accommRoomId}">${room.roomName}</option>
      </c:forEach>
    </select>
  </div>

  <!-- 금액 입력 폼 -->
  <div class="form-section" style="margin-bottom: 30px;">
    <h3>신규 요금 등록</h3>
    <form id="priceInsertForm">
      <input type="hidden" name="roomId" id="inputRoomId" />
      <div class="form-row">
        <label>적용 기간</label>
        <input type="date" name="startDate" required> ~
        <input type="date" name="endDate" required>
      </div>
      <div class="form-row">
        <label>평일 요금</label>
        <input type="number" name="weekdayPrice" required>
      </div>
      <div class="form-row">
        <label>금요일 요금</label>
        <input type="number" name="fridayPrice" required>
      </div>
      <div class="form-row">
        <label>토요일 요금</label>
        <input type="number" name="saturdayPrice" required>
      </div>
      <div class="form-row">
        <label>일요일 요금</label>
        <input type="number" name="sundayPrice" required>
      </div>
      <div class="form-row" style="text-align: right;">
        <button type="submit">요금 등록</button>
      </div>
    </form>
  </div>

  <!-- 기존 요금 테이블 -->
  <div id="priceListContainer">
    <h3>기존 요금 목록</h3>
    <table id="priceTable" style="display: none;">
      <thead>
        <tr>
          <th>적용 기간</th>
          <th>평일</th>
          <th>금요일</th>
          <th>토요일</th>
          <th>일요일</th>
          <th>삭제</th> 
        </tr>
      </thead>
      <tbody id="priceTableBody"></tbody>
    </table>
    <div id="noPriceMsg" style="display: none;">등록된 요금이 없습니다.</div>
  </div>
</div>

<!-- JavaScript -->
<script>
function formatDate(dateStr) {
	  const d = new Date(dateStr);
	  if (isNaN(d.getTime())) return "-";
	  return d.toISOString().slice(0, 10);
}

document.getElementById("roomIdSelect").addEventListener("change", function () {
  const roomId = this.value;
  const tbody = document.getElementById("priceTableBody");
  document.getElementById("inputRoomId").value = roomId;
  tbody.innerHTML = "";

  if (!roomId) return;

  fetch("/roomPrice/list?roomId=" + encodeURIComponent(roomId))
    .then(res => res.json())
    .then(data => {
    	console.log(data)
      const table = document.getElementById("priceTable");
      const noData = document.getElementById("noPriceMsg");

      if (data && data.length > 0) {
    	  data.forEach(price => {
    		  const tr = document.createElement("tr");

    		  const dateTd = document.createElement("td");
    		  dateTd.textContent = formatDate(price.accommRoomPriceStart) + " ~ " + formatDate(price.accommRoomPriceEnd);
    		  tr.appendChild(dateTd);

    		  const weekdayTd = document.createElement("td");
    		  weekdayTd.textContent = numberWithCommas(price.accommRoomPriceWeekday);
    		  tr.appendChild(weekdayTd);

    		  const fridayTd = document.createElement("td");
    		  fridayTd.textContent = numberWithCommas(price.accommRoomPriceFriday);
    		  tr.appendChild(fridayTd);

    		  const saturdayTd = document.createElement("td");
    		  saturdayTd.textContent = numberWithCommas(price.accommRoomPriceSaturday);
    		  tr.appendChild(saturdayTd);

    		  const sundayTd = document.createElement("td");
    		  sundayTd.textContent = numberWithCommas(price.accommRoomPriceSunday);
    		  tr.appendChild(sundayTd);

    		  const deleteTd = document.createElement("td");
    		  const deleteBtn = document.createElement("button");
    		  deleteBtn.textContent = "삭제";
    		  deleteBtn.style.backgroundColor = "#d9534f";
    		  deleteBtn.style.color = "#fff";
    		  deleteBtn.style.border = "none";
    		  deleteBtn.style.padding = "6px 12px";
    		  deleteBtn.style.borderRadius = "4px";
    		  deleteBtn.style.cursor = "pointer";

    		  deleteBtn.addEventListener("click", () => {
    		    if (!confirm("이 요금을 정말 삭제하시겠습니까?")) return;

    		    fetch("/roomPrice/delete", {
    		      method: "POST",
    		      headers: { "Content-Type": "application/json" },
    		      body: JSON.stringify({ priceId: price.accommRoomPriceId })
    		    })
    		      .then(res => res.json())
    		      .then(res => {
    		        if (res.status === "ok") {
    		          alert("삭제되었습니다.");
    		          document.getElementById("roomIdSelect").dispatchEvent(new Event("change"));
    		        } else {
    		          alert("삭제 실패: " + res.message);
    		        }
    		      })
    		      .catch(err => alert("삭제 요청 중 오류 발생: " + err.message));
    		  });

    		  deleteTd.appendChild(deleteBtn);
    		  tr.appendChild(deleteTd);

    		  tbody.appendChild(tr);
    		});

        table.style.display = "table";
        noData.style.display = "none";
      } else {
        table.style.display = "none";
        noData.style.display = "block";
      }
    });
});

// 요금 등록
document.getElementById("priceInsertForm").addEventListener("submit", function (e) {
  e.preventDefault();

  const formData = new FormData(this);
  formData.set("startDate", formData.get("startDate").slice(0, 10));
  formData.set("endDate", formData.get("endDate").slice(0, 10));

  const json = Object.fromEntries(formData.entries());

  fetch("/roomPrice/insert", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(json)
  })
    .then(res => res.json())
    .then(res => {
      if (res.status === "ok") {
        alert("요금이 등록되었습니다.");
        document.getElementById("roomIdSelect").dispatchEvent(new Event("change"));
        this.reset();
      } else {
        alert("등록 실패: " + res.message);
      }
    })
    .catch(err => {
      alert("에러 발생: " + err.message);
    });
});

function numberWithCommas(x) {
  if (x == null || isNaN(x)) return "-";
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>
</body>
</html>
