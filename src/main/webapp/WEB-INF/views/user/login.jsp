<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/taglib.jsp" %>


<!DOCTYPE html>
<html>
<head>
 <%@ include file="/WEB-INF/views/include/head3.jsp" %>
  <title>로그인</title>
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #fff;
    }

    .nav {
      background-color: #707b82;
      padding: 10px 20px;
      color: white;
    }

    .nav a {
      color: #dcdcdc;
      text-decoration: none;
      margin-right: 15px;
      font-weight: bold;
    }

    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 80vh;
    }

    .login-box {
      width: 300px;
      text-align: center;
    }

    .login-box h2 {
     
      margin-bottom: 20px;
    }

    .input-box {
      width: 100%;
      padding: 10px;
      margin-bottom: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 14px;
    }

    .btn {
      width: 100%;
      padding: 10px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 15px;
      margin-top: 5px;
      cursor: pointer;
    }

    .btn:hover {
      background-color: #0056cc;
    }
  </style>
  
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
					
					if(code == 0)
					{
						//alert("로그인성공");
						location.href = "/user/userUpdateForm";
					}
					else
					{
						if(code == -1)
						{
							alert("비밀번호가 올바르지 않습니다.");
							$("#userPwd").focus();
						}
						else if(code == -99)
						{
							alert("정지된 사용자 입니다.");
							$("#userId").focus();
						}
						else if(code == 404)
						{
							alert("아이디와 일치하는 사용자 정보가 없습니다");
							$("#userId").focus();
						}
						else if(code == 400)
						{
							alert("파라미터 값이 올바르지 않습니다.");
							$("#userId").focus();
						}
						else
						{
							alert("오류가 발생하였습니다.(1)");
							$("#userId").focus();
						}
					}
				}
				else
				{
					alert("오류가 발생하였습니다.");
					$("#userId").focus();
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

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <div class="container">
    <div class="login-box">
      <h2>로그인</h2>
      <form action="/login" method="POST">
        <input type="text" id="userId" name="userId" class="input-box" placeholder="아이디" required>
        <input type="password" id="userPassword"  name="userPassword" class="input-box" placeholder="비밀번호" required>
        <button type="button"  id="btnLogin" class="btn">로그인</button>
        <button type="button" id="btnReg" class="btn">회원가입</button>
      </form>
    </div>
  </div>
</body>
</html>