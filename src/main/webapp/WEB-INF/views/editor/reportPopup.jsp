<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String planId = request.getParameter("planId");
  String userId = (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>신고하기</title>

  <!-- 기본 스타일 -->
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 30px;
      color: #333;
    }

    .container {
      max-width: 400px;
      margin: 0 auto;
      background: #fff;
      padding: 30px 25px;
      border-radius: 15px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
    }

    h2 {
      font-size: 20px;
      margin-bottom: 20px;
      color: #444;
      text-align: center;
    }

    label {
      display: block;
      margin: 10px 0;
      font-size: 15px;
      cursor: pointer;
    }

    input[type="radio"] {
      margin-right: 8px;
    }

    button {
      width: 100%;
      padding: 10px;
      border: none;
      border-radius: 8px;
      background-color: #666;
      color: white;
      font-size: 15px;
      cursor: pointer;
      margin-top: 20px;
      transition: background-color 0.2s;
    }

    button:hover {
      background-color: #444;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>신고 사유를 선택해주세요</h2>

    <form id="reportForm">
      <!-- 숨김값 -->
      <input type="hidden" name="planId" value="<%= planId %>">
      <input type="hidden" name="userId" value="<%= userId %>">

      <!-- 신고 사유 -->
      <label><input type="radio" name="reason" value="1">욕설</label>
      <label><input type="radio" name="reason" value="2">도배</label>
      <label><input type="radio" name="reason" value="3">광고</label>
      <label><input type="radio" name="reason" value="4">기타</label>

      <button type="button" onclick="submitReport()">신고 제출</button>
    </form>
  </div>

  <script>
    function submitReport() {
      const form = document.getElementById('reportForm');
      const formData = new FormData(form);
      const params = new URLSearchParams();

      for (const [key, value] of formData.entries()) {
        params.append(key, value);
      }

      fetch('/editor/report', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params
      })
      .then(res => res.json())
      .then(data => {
        if (data.code === 0) {
          alert("신고가 접수되었습니다.");
          window.close();
        } else if (data.code === -1) {
          alert("이미 신고한 게시글입니다.");
          window.close();
        } else {
          alert("신고 실패: " + data.message);
          window.close();
        }
      })
      .catch(error => {
        alert("오류 발생: " + error);
        window.close();
      });
    }
  </script>
</body>
</html>
