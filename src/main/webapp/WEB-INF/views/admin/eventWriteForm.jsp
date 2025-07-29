<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .event-form-container {
        max-width: 600px;
        margin: 40px auto;
        padding: 30px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background-color: #f9f9f9;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }

    .event-form-container h3 {
        text-align: center;
        margin-bottom: 25px;
        color: #333;
    }

    .event-form-container form input[type="text"],
    .event-form-container form input[type="date"],
    .event-form-container form select,
    .event-form-container form input[type="file"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 18px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .event-form-container form button {
        width: 100%;
        padding: 12px;
        background-color: #007bff;
        border: none;
        color: #fff;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
    }

    .event-form-container form button:hover {
        background-color: #0056b3;
    }

    .event-form-container label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }
</style>

<div class="event-form-container">
    <h3>이벤트 작성</h3>
    
    <form id="eventForm" method="post" enctype="multipart/form-data" action="/admin/eventInsert">
        <label for="eventTitle">이벤트 제목</label>
        <input type="text" id="eventTitle" name="eventTitle" placeholder="이벤트 제목" required />
		
		<label for="eventContent">이벤트 내용</label>
		<textarea id="eventContent" name="eventContent" rows="5" placeholder="이벤트 본문 내용 입력" required></textarea>
		
        <label for="couponId">쿠폰 선택</label>
        <select name="couponId" id="couponId">
            <option value="">-- 쿠폰 선택 --</option>
            <c:forEach var="coupon" items="${couponList}">
                <option value="${coupon.couponId}">${coupon.couponName}</option>
            </c:forEach>
        </select>

        <label for="eventEnddate">이벤트 종료일</label>
        <input type="date" id="eventEnddate" name="eventEnddate" required />
	
        <label for="eventThumbnail">썸네일 이미지 업로드</label>
        <input type="file" id="eventThumbnail" name="eventThumbnail" accept="image/png" required />

        <label for="eventDetailImage">본문 이미지 업로드</label>
        <input type="file" id="eventDetailImage" name="eventDetailImage" accept="image/png" required />

        <button type="submit" id="submitEventBtn">이벤트 등록</button>
    </form>
</div>

<script>


</script>
