<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <%@ include file="/WEB-INF/views/include/userHead.jsp" %>
 <title>판매자 로그인</title>
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
						location.href = "/seller/sellerUpdateForm";
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
 <%@ include file="/WEB-INF/views/include/navigation2.jsp" %>

  <div class="container">
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