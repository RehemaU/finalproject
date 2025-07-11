<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
  justify-content: flex-start; 
  align-items: center;
  height: calc(100vh - 60px); /* 네비 높이 감안 */
  padding: 100px 600px;
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
  	$(document).ready(function(){
  		$("#sellerId").focus();
  		
  		$("#sellerId").on("keypress", function(e){
			if(e.which == 13)
			{
				fn_loginCheck();
			}			
		});
  		
  		$("#sellerPassword").on("keypress", function(e){
			if(e.which == 13)
			{
				fn_loginCheck();  
			}	
		});
  		
  		$("#btnLogin").on("click", function(){
			fn_loginCheck();	
		});
  		
  		$("#btnReg").on("click", function(){
			location.href = "/seller/sellerRegForm";
		});
  	});
  	
  	
  	function fn_loginCheck()
	{
		if($.trim($("#sellerId").val()).length <= 0)
		{
			alert("판매자 아이디를 입력하세요.");
			$("#sellerId").val("");
			$("#sellerId").focus();
			return;
		}
		
		if($.trim($("#sellerPassword").val()).length <= 0)
		{
			alert("판매자 비밀번호를 입력하세요.");
			$("#sellerPassword").val("");
			$("#sellerPassword").focus();
			return;
		}
		
		$.ajax({
			type:"POST",
			url:"/seller/loginProc",
			data:{
				sellerId:$("#sellerId").val(),
				sellerPassword:$("#sellerPassword").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX","true");
			},
			success:function(response){
				if(!icia.common.isEmpty(response))
				{
					icia.common.log(response);
					var code = icia.common.objectValue(response, "code", -500);
					
					if(code == 0)
					{
						location.href = "/seller/sellerMain";
					}
					else
					{
						if(code == -1)
						{
							alert("비밀번호가 올바르지 않습니다.");
							$("#sellerPassword").focus();
						}
						else if(code == 404)
						{
							alert("아이디와 일치하는 사용자 정보가 없습니다");
							$("#sellerId").focus();
						}
						else if(code == 400)
						{
							alert("파라미터 값이 올바르지 않습니다.");
							$("#sellerId").focus();
						}
						else
						{
							alert("오류가 발생하였습니다.");
							$("#sellerId").focus();
						}
					}
				}
				else
				{
					alert("오류가 발생하였습니다.");
					$("#sellerId").focus();
				}
			},
			complete:function(data)
			{
				//응답이 종료되면 실행함(잘 사용하지 않음)
				icia.common.log(data);
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}			
		});
	}
  </script>
</head>
<body>
 <%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>

  <div class="login-container">
    <div class="login-box">
      <h2>판매자 로그인</h2>
      <form action="/login" method="POST">
        <input type="text" id="sellerId" name="sellerId" class="input-box" placeholder="아이디" required>
        <input type="password" id="sellerPassword"  name="sellerPassword" class="input-box" placeholder="비밀번호" required>
        <button type="button"  id="btnLogin" class="btn">로그인</button>
        <button type="button" id="btnReg" class="btn">판매자등록</button>
      </form>
    </div>
  </div>
</body>
</html>