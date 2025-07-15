<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
	String accommId = request.getParameter("accommId");
	String orderId = request.getParameter("orderId");
	String userId = (String) session.getAttribute("userId");
%>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>후기 작성</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 30px;
      background-color: #f2f2f2;
      color: #333;
    }

    h2 {
      margin-bottom: 20px;
      color: #444;
    }

    .star-rating {
      direction: rtl;
      font-size: 28px;
      text-align: center;
      margin-bottom: 20px;
    }

    .star-rating input {
      display: none;
    }

    .star-rating label {
      color: #ccc;
      cursor: pointer;
      transition: color 0.2s;
    }

    .star-rating input:checked ~ label,
    .star-rating label:hover,
    .star-rating label:hover ~ label {
      color: #000; /* 무채색 별점 */
    }

    textarea {
      width: 100%;
      height: 200px;
      resize: none;
      border: 1px solid #ccc;
      border-radius: 6px;
      padding: 10px;
      font-size: 14px;
      background-color: #fff;
      color: #333;
      margin-bottom: 20px;
      box-sizing: border-box; /* ← 핵심 */
    }

    .submit-btn {
      background-color: #333;
      color: #fff;
      border: none;
      padding: 10px 24px;
      border-radius: 30px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      display: block;
      margin: 0 auto;
      transition: background-color 0.2s;
    }

    .submit-btn:hover {
      background-color: #555;
    }
  </style>
</head>
<body>

<div>
  <h2>후기 작성</h2>

  <form id="reviewForm">
    
    <input type="hidden" name="accommId" value="<%= accommId %>">
    <input type="hidden" name="orderId" value="<%= orderId %>">
    <input type="hidden" name="userId" value="<%= userId %>">
    
    
    <!-- 별점 입력 -->
    <div class="star-rating">
      <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
      <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
      <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
      <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
      <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
    </div>

    <!-- 후기 텍스트 -->
    <textarea name="content" placeholder="후기를 작성해주세요..."></textarea>

    <!-- 등록 버튼 -->
    <button type="button" class="submit-btn" onclick="submitReview()">후기 등록</button>
  </form>

<script>
function submitReview(event) {

  const form = document.getElementById('reviewForm');

  const formData = new FormData(form);

  fetch('/mypage/review', {
	    method: 'POST',
	    body: formData
	  })
	  .then(res => res.json())
	  .then(data => {
	    if(data.code === 0) {
	      alert("리뷰 등록 완료!");
	      window.close(); // 팝업 닫기
	    } else if(data.code === -10) {
	    	alert("리뷰가 이미 존재합니다.");
	    	window.close();
	    } else {
	      alert("리뷰 등록 실패: " + data.message);
	    }
	  })
	  .catch(err => {
	    console.error(err);
	    alert("서버 오류 발생");
	  });
}
</script>


</div>
</body>
</html>
