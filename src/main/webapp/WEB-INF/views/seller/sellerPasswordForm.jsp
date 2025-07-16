<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/sellerHead.jsp" %>
  <title>비밀번호 변경</title>
  <style>
    :root {
    --bg: #ffffff;
    --fg: #000000;
    --border: #e5e5e5;
    --radius: 12px;
    --primary: #000000;
    --gray: #666;
  }

  body {
    margin: 0;
    background: var(--bg);
    color: var(--fg);
    font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
    font-size: 15px;
    line-height: 1.5;
    padding: 60px 20px;
  }

  .container {
    max-width: 460px;
    margin: 0 auto;
    padding: 48px 40px;
    border: 1px solid var(--border);
    border-radius: var(--radius);
    background: #fff;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  }

  h2 {
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 30px;
    text-align: center;
  }

  .info-text {
    font-size: 14px;
    margin-bottom: 36px;
    color: var(--gray);
    line-height: 1.6;
  }

  .info-text a {
    color: var(--fg);
    font-weight: 600;
    text-decoration: underline;
  }

  .info-text .red {
    color: #c40000;
  }

  .form-group {
    margin-bottom: 24px;
  }

  input[type="password"] {
    width: 100%;
    padding: 16px;
    font-size: 15px;
    border: 1px solid var(--border);
    border-radius: var(--radius);
    background-color: #fafafa;
    transition: border-color 0.2s ease;
  }

  input[type="password"]:focus {
    outline: none;
    border-color: #999;
    background-color: #fff;
  }

  button {
    width: 100%;
    padding: 16px;
    font-size: 16px;
    font-weight: 700;
    background-color: var(--primary);
    color: white;
    border: none;
    border-radius: var(--radius);
    cursor: pointer;
    transition: opacity 0.2s ease;
  }

  button:hover {
    opacity: 0.85;
  }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>

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
      
      <input type="hidden" id="sellerPassword" name="sellerPassword">
      <button type="button" id="btnChange" >비밀번호 변경</button>
    </form>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
		        url: "/seller/checkCurrentPassword", // 서버에서 현재 비밀번호 확인하는 컨트롤러 URL
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
		   			url: "/seller/sellerPasswordChange",
		   			type:"POST",
		   			data: { sellerPassword: newPw },
		   			success:function(response)
		   			{
		   				if(response.code == 0)
		   				{
		   					alert("비밀번호가 성공적으로 변경되었습니다.");
		   					location.href = "/seller/sellerMain"; 
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

</body>
</html>