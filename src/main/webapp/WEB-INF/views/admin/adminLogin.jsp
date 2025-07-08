
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MYTRIP – Admin Login</title>

  <!-- Fonts & Tailwind -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />

  <!-- Scripts -->
  <script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
  <script type="text/javascript" src="/resources/js/icia.common.js"></script>
  <script type="text/javascript" src="/resources/js/icia.ajax.js"></script>

  <style>
    body {
      margin: 0;
      font-family: 'Pretendard', sans-serif;
      background-color: #ffffff;
    }

    .login-container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 80vh;
      padding: 24px;
    }

    .login-box {
      width: 100%;
      max-width: 360px;
      background: #fff;
      border: 1px solid #e5e5e5;
      border-radius: 16px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.06);
      padding: 32px;
    }

    .login-box h2 {
      font-size: 24px;
      font-weight: 700;
      text-align: center;
      margin-bottom: 24px;
    }

    .input-box {
      width: 100%;
      padding: 12px 14px;
      margin-bottom: 16px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 15px;
      background-color: #fafafa;
    }

    .btn {
      width: 100%;
      padding: 12px;
      background-color: #000;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 15px;
      font-weight: 600;
      cursor: pointer;
      margin-top: 8px;
      transition: background-color 0.2s ease;
    }

    .btn:hover {
      background-color: #333;
    }
  </style>

  <script>
    $(document).ready(function() {
      $("#adminId").focus();

      $("#adminId, #adminPassword").on("keypress", function(e) {
        if (e.which === 13) fn_adminLogin();
      });

      $("#btnAdminLogin").on("click", function() {
        fn_adminLogin();
      });
    });

    function fn_adminLogin() {
      const id = $.trim($("#adminId").val());
      const pw = $.trim($("#adminPassword").val());

      if (id.length === 0) {
        alert("아이디를 입력하세요.");
        $("#adminId").focus();
        return;
      }

      if (pw.length === 0) {
        alert("비밀번호를 입력하세요.");
        $("#adminPassword").focus();
        return;
      }

      $.ajax({
        type: "POST",
        url: "/admin/loginProc",
        data: {
          adminId: id,
          adminPassword: pw
        },
        datatype: "JSON",
        beforeSend: function(xhr) {
          xhr.setRequestHeader("AJAX", "true");
        },
        success: function(res) {
          if (!icia.common.isEmpty(res)) {
            const code = icia.common.objectValue(res, "code", -500);
            if (code === 0) {
              location.href = "/admin/dashboard"; // 관리자 첫 화면으로 이동
            } else if (code === -1) {
              alert("비밀번호가 올바르지 않습니다.");
            } else if (code === 404) {
              alert("관리자 계정을 찾을 수 없습니다.");
            } else {
              alert("로그인 실패. 관리자에게 문의하세요.");
            }
          } else {
            alert("서버 오류 발생.");
          }
        },
        error: function(xhr, status, error) {
          console.error(error);
          alert("에러 발생: " + error);
        }
      });
    }
  </script>
</head>

<body>
  <div class="login-container">
    <div class="login-box">
      <h2>Admin Login</h2>
      <form onsubmit="return false;">
        <input type="text" id="adminId" name="adminId" class="input-box" placeholder="아이디" required>
        <input type="password" id="adminPassword" name="adminPassword" class="input-box" placeholder="비밀번호" required>
        <button type="button" id="btnAdminLogin" class="btn">로그인</button>
      </form>
    </div>
  </div>
</body>
</html>
