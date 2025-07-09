<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>

<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MYTRIP – Walkthrough · Explore · Stay · Plan · Share</title>

  <!-- Fonts & Tailwind -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />

  <!-- Scripts -->
  <script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
  <script type="text/javascript" src="/resources/js/icia.common.js"></script>
  <script type="text/javascript" src="/resources/js/icia.ajax.js"></script>

  <!-- Custom Fixes for Tailwind Override -->
 
  <!-- 로그인 스타일 -->
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

  <!-- 로그인 로직 -->
  <script>
   $(document).ready(function(){
      $("#userId").focus();
      
      $("#userId").on("keypress", function(e){
         if(e.which == 13)
         {
            fn_loginCheck();
         }         
      });
      
      $("#userPassword").on("keypress", function(e){
         if(e.which == 13)
         {
            fn_loginCheck();
         }   
      });
      
      $("#btnLogin").on("click", function(){
         fn_loginCheck();   
      });
      
      $("#btnReg").on("click", function(){
         location.href = "/user/userRegForm";
      });
      
      $("#btnkakao").on("click", function(){
          //location.href = "https://kauth.kakao.com/oauth/authorize?client_id=80e4419557c7b5feaa6bcbaa1cae6ae8&redirect_uri=http://finalproject.sist.co.kr:8088/user/kakaoLogin&response_type=code&scope=profile_nickname";
    	  //location.href = "https://kauth.kakao.com/oauth/authorize?client_id=abc12345678901234567890123456789&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fkakao%2Fcallback&response_type=code&prompt=login";
    	  //location.href = "https://kauth.kakao.com/oauth/authorize?client_id=80e4419557c7b5feaa6bcbaa1cae6ae8&redirect_uri=http://finalproject.sist.co.kr:8088/user/kakaoLogin&response_type=code&scope=profile_nickname&prompt=login";
    	  location.href = "https://kauth.kakao.com/oauth/authorize"
    	    			+ "?client_id=80e4419557c7b5feaa6bcbaa1cae6ae8"
    	    			+ "&redirect_uri=http://finalproject.sist.co.kr:8088/user/kakaoLogin"
    	   			    + "&response_type=code"
    	    			+ "&scope=profile_nickname"
    	    			+ "&prompt=login";
      }); 
      
      $("#btngoogle").on("click", function(){
    	  location.href = "https://accounts.google.com/o/oauth2/v2/auth?client_id=292826362473-d70q9e2i8kaiksg49ij9vfhhupbv61fq.apps.googleusercontent.com&redirect_uri=http://finalproject.sist.co.kr:8088/user/googleLogin&response_type=code&scope=openid%20email%20profile&access_type=offline&prompt=select_account";
      }); 
   });
   
   function fn_loginCheck()
   {
      if($.trim($("#userId").val()).length <= 0)
      {
         alert("아이디를 입력하세요.");
         $("#userId").val("");
         $("#userId").focus();
         return;
      }
      
      if($.trim($("#userPassword").val()).length <= 0)
      {
         alert("비밀번호를 입력하세요.");
         $("#userPassword").val("");
         $("#userPassword").focus();
         return;
      }
      
      $.ajax({
         type:"POST",
         url:"/user/loginProc",
         data:{
            userId:$("#userId").val(),
            userPassword:$("#userPassword").val()
         },
         datatype:"JSON",
         beforeSend:function(xhr){
            xhr.setRequestHeader("AJAX", "true");
         },
         success:function(response){
            if(!icia.common.isEmpty(response))
            {
               icia.common.log(response);
               var code = icia.common.objectValue(response, "code", -500);
               if(code == 0) location.href = "/";
               else {
                  if(code == -1) alert("비밀번호가 올바르지 않습니다.");
                  else if(code == -99) alert("탈퇴한 사용자 입니다.");
                  else if(code == 404) alert("아이디와 일치하는 사용자 정보가 없습니다");
                  else if(code == 400) alert("파라미터 값이 올바르지 않습니다.");
                  else alert("오류가 발생하였습니다.(1)");
                  $("#userId").focus();
               }
            } else {
               alert("오류가 발생하였습니다.");
               $("#userId").focus();
            }
         },
         complete:function(data){ icia.common.log(data); },
         error:function(xhr, status, error){ icia.common.error(error); }
      });
   }
  </script>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <div class="login-container">
    <div class="login-box">
      <h2>Login</h2>
      <form action="/login" method="POST">
        <input type="text" id="userId" name="userId" class="input-box" placeholder="아이디" required>
        <input type="password" id="userPassword" name="userPassword" class="input-box" placeholder="비밀번호" required>
        <button type="button" id="btnLogin" class="btn">로그인</button>
        <button type="button" id="btnReg" class="btn">회원가입</button>
        <!--카카오로그인 -->
        <button type="button" id="btnkakao" class="btn">카카오로그인</button>
        <!--구글로그인 -->
        <button type="button" id="btngoogle" class="btn">구글로그인</button>
      </form>
    </div>
  </div>
</body>
</html>
