<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/userHead.jsp" %>
  <title>비밀번호 변경</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 40px;
      background-color: #fff;
      color: #333;
    }

    .container {
      max-width: 400px;
    }

    h2 {
      font-size: 20px;
      margin-bottom: 10px;
    }

    .info-text {
      font-size: 14px;
      margin-bottom: 20px;
    }

    .info-text a {
      color: #007bff;
      text-decoration: none;
    }

    .info-text .red {
      color: red;
    }

    .form-group {
      margin-bottom: 15px;
    }

    input[type="password"] {
      width: 100%;
      padding: 12px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }

    button {
      width: 100%;
      padding: 12px;
      font-size: 15px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    button:hover {
      background-color: #005fcc;
    }
  </style>
  <script type="text/javascript">
  $(document).ready(function(){
	  $("#btnChange").on("click",function(){
		  var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
		  var currentPw = $("#currentPassword").val();
		  var newPw = $("#newPassword").val();
		  var confirmPw = $("#confirmPassword").val();
		  if ($.trim(currentPw).length <= 0) 
		  {
		     alert("현재 비밀번호를 입력하세요.");
		     $("#currentPassword").focus();
		     return;
		  }
		  

		   if (!idPwCheck.test(newPw))
		   {
		       alert("새 비밀번호는 영문 대소문자 숫자로 4~12자리로 입력해야 합니다.");
		       //$("#newPassword").val("").focus();
		       $("#newPassword").val("");
		       $("#newPassword").focus();
		       return;
		    }
		   
		   if ($.trim(confirmPw).length <= 0) 
		   {
		        alert("새 비밀번호 확인을 입력하세요.");
		        //$("#confirmPassword").val("").focus();
		        $("#confirmPassword").val("");
		        $("#confirmPassword").focus();
		        return;
		   }
		   if (newPw != confirmPw) 
		   {
		        alert("새 비밀번호가 일치하지 않습니다.");
		        $("#confirmPassword").focus();
		        return;
		    }
		   
		   $.ajax({
		        url: "/user/checkCurrentPassword", // 서버에서 현재 비밀번호 확인하는 컨트롤러 URL
		        type: "POST",
		        data: { currentPassword: currentPw },
		        async: false, 
		        success: function(result) {
		            if (result === true || result === "true") {
		            	// 현재 비밀번호가 맞는 경우, 새 비밀번호 확인 진행
		            	if(newPw != confirmPw)
		            	{
		            		alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
		            		$("#confirmPassword").focus();
		            		return;
		            	}
		            	
		            	//비밀번호 변경 Ajax
		            	changePassword(newPw);
		            }
		            else
		            {
		            	alert("현재 비밀번호가 올바르지 않습니다.");
		            	$("#currentPassword").focus();
		            }
		        },
		        error: function() {
		            alert("현재 비밀번호 확인 중 오류가 발생했습니다.");
		            $("#currentPassword").focus();
		        }
		    });
		   
		   	function changePassword(newPw)
	  		{
		   		$.ajax({
		   			url: "/user/userPasswordChange",
		   			type:"POST",
		   			data: { userPassword: newPw },
		   			success:function(response)
		   			{
		   				if(response.code == 0)
		   				{
		   					alert("비밀번호가 성공적으로 변경되었습니다.");
		   					location.href = "/user/login"; 
		   				}
		   				else
		   				{
		   					alert("비밀번호 변경에 실패했습니다.");
		   				}
		   			},
		   			error:function(){
		   				alert("비밀번호 변경 중 오류가 발생했습니다.");
		   			}
		   			
		   		});
		   
	  		}

	  });
  });
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <div class="container">
    <h2>비밀번호 변경</h2>
    <div class="info-text">
      <a href="#">안전한 비밀번호</a>로 내정보를 보호하세요<br><br>
      <span class="red">・ 다른 아이디/사이트에서 사용한 적 없는 비밀번호</span><br>
      <span class="red">・ 이전에 사용한 적 없는 비밀번호</span>가 안전합니다.
    </div>

    <form method="post">
      <div class="form-group">
        <input type="password" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호" required>
      </div>
      <div class="form-group">
        <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
      </div>
      <div class="form-group">
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="새 비밀번호 확인" required>
      </div>
      
      <input type="hidden" id="userPassword" name="userPassword">
      <button type="button" id="btnChange" >비밀번호 변경</button>
    </form>
  </div>

</body>
</html>