<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/userHead.jsp" %>
  <title>판매자등록</title>
  <style>
    :root{
    --fg:#000;            /* 기본 글자색 */
    --bg:#ffffff;         /* 배경색 */
    --border:#e5e5e5;     /* 얇은 회색선 */
    --primary:#000000;    /* 액션‧포인트 컬러 = 블랙 */
    --radius:12px;        /* 둥근 정도 */
  }

  /* 레이아웃 ──────────────────────────── */
  body{
    margin:0;
    background:var(--bg);
    color:var(--fg);
    font-family:'Pretendard', sans-serif;
    font-size:15px;
    line-height:1.5;
  }
  .signup-container{
    max-width:480px;               /* 여백 넉넉하게 */
    margin:80px auto;              /* 위·아래 간격 */
    padding:48px 56px;
    border:1px solid var(--border);
    border-radius:var(--radius);
    background:#fff;
    box-shadow:0 4px 20px rgba(0,0,0,.04);
  }
  .signup-container h2{
    font-size:28px;
    font-weight:700;
    text-align:center;
    margin-bottom:40px;
    letter-spacing:-.4px;
  }

  /* 폼 요소 ───────────────────────────── */
  .form-group{margin-bottom:24px;display:flex;flex-direction:column;gap:8px;}
  label{font-size:15px;font-weight:600;}

  input[type="text"],
  input[type="password"],
  input[type="email"],
  input[type="file"],
  select{
    padding:14px 16px;
    font-size:15px;
    border:1px solid var(--border);
    border-radius:var(--radius);
    background:#fafafa;
    transition:border-color .15s;
  }
  input[type="text"]:focus,
  input[type="password"]:focus,
  input[type="email"]:focus,
  input[type="file"]:focus,
  select:focus{
    outline:none;
    border-color:#666;
    background:#fff;
  }
  input[readonly]{background:#f5f5f5;color:#888;cursor:not-allowed;}

  /* 주소 섹션 – 버튼 옆 정렬 */
  .address-group{gap:16px}
  .address-group button{
    height:46px;
    padding:0 24px;
    border:none;
    border-radius:var(--radius);
    background:var(--primary);
    color:#fff;
    font-weight:600;
    cursor:pointer;
    transition:opacity .15s;
  }
  .address-group button:hover{opacity:.85;}

  /* date 입력이 텍스트로 바뀐 뒤도 동일 스타일 유지 */
  input[type="date"],
  input[type="text"][id="userBirth"]{
    appearance:none;
    -webkit-appearance:none;
  }

  /* 제출 버튼 ─────────────────────────── */
  .submit-btn{
    width:100%;
    padding:16px 0;
    font-size:16px;
    font-weight:700;
    background:var(--primary);
    color:#fff;
    border:none;
    border-radius:var(--radius);
    cursor:pointer;
    transition:opacity .15s;
    margin-top:32px;
  }
  .submit-btn:hover{opacity:.85;}
 
  </style>
  <script type="text/javascript">
  	$(document).ready(function(){
  		$("#sellerId").focus();
  		
  		$("#btnReg").on("click",function(){
  			//공백체크
  			var emptCheck = /\s/g;
  			
  			//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
  			var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
  			
  			// 010-1234-5678 또는 01012345678 형식 허용
  			var phoneCheck = /^01[016789]-?\d{3,4}-?\d{4}$/;
  			
  			if($.trim($("#sellerId").val()).length <= 0)
  			{
  				alert("판매자 아이디를 입력하세요.");
  				$("#sellerId").val("");
  				$("#sellerId").focus();
  				return;
  			}
  			
  			if(emptCheck.test($("#sellerId").val()))
  			{
  				alert("판매자 아이디는 공백을 포함할수 없습니다.");
  				$("#sellerId").focus();
  				return;
  			}
  			
  			if(!idPwCheck.test($("#sellerId").val()))
  			{
  				alert("판매자 아이디는 4~12자의 영문 대소문자와 숫자로만 입력가능합니다.");
  				$("#sellerId").val("");
  				$("#sellerId").focus();
  				return;
  			}
  			
  			if($.trim($("#sellerPassword1").val()).length <= 0)
  			{
  				alert("비밀번호를 입력하세요.");
  				$("#sellerPassword1").val("");
  				$("#sellerPassword1").focus();
  				return;
  			}
  			
  			if(!idPwCheck.test($("#sellerPassword1").val()))
  			{
  				alert("비밀번호는 영문 대소문자 숫자로 4~12자리로 입력가능합니다.");
  				$("#sellerPassword1").val("");
  				$("#sellerPassword1").focus();
  				return;
  			}
  			
  			if($.trim($("#sellerPassword2").val()).length <= 0)
			{
				alert("비밀번호 확인을 입력하세요.");
				$("#sellerPassword2").val("");
  				$("#sellerPassword2").focus();
  				return;
			}
  			
  			if($("#sellerPassword1").val() != $("#sellerPassword2").val())
  			{
  				alert("비밀번호가 일치하지 않습니다.");
  				$("#sellerPassword2").focus();
  				return;
  			}
  			
  			$("#sellerPassword").val($("#sellerPassword2").val());
  			
  			if($.trim($("#sellerName").val()).length <= 0)
  			{
  				alert("판매자 이름을 입력하세요");
  				$("#sellerName").val("");
  				$("#sellerName").focus();
  				return;			
  			}
  			
  			var sellerPhone = $.trim($("#sellerNumber").val());
  			if (!phoneCheck.test(sellerPhone)) {
  			  alert("전화번호는 010-1234-5678 형식으로 입력하세요.");
  			  $("#sellerNumber").val("");
  			  $("#sellerNumber").focus();
  			  return;
  			}
  			
  			if($.trim($("#sellerEmail").val()) <= 0)
  			{
  				alert("판매자 이메일을 입력하세요.");
  				$("#sellerEmail").val("");
  				$("#sellerEmail").focus();
  				return;
  			}
  			
  			if(!fn_validateEmail($("#sellerEmail").val()))
  			{
  				alert("판매자 이메일 형식이 올바르지 않습니다.");
  				$("#sellerEmail").focus();
  				return;
  			}
  			
  			if($.trim($("#sellerBusiness").val()).length <= 0)
  			{
  				alert("상호명을 입력하세요");
  				$("#sellerBusiness").val("");
  				$("#sellerBusiness").focus();
  				return;			
  			}
  			
  			if (!checkBusinessNumber()) {
  		        $("#sellerSellnumber").focus();
  		        return;
  		    }
  			
  			//중복아이디 체크 aJax
  			$.ajax({
  				type:"POST",
  				url:"/seller/idCheck",
  				data:{
  					sellerId:$("#sellerId").val()
  				},
  				datatype:"JSON",
  				beforeSend:function(xhr)
  				{
  					xhr.setRequestHeader("AJAX", "true");
  				},
  				success:function(response)
  				{
  					if(response.code == 0)
  					{
  						alert("판매자 가입이 가능합니다.");
  						fn_userReg();
  					}
  					else if(response.code == 100)
  					{
  						alert("중복아이디 입니다.");
  						$("#sellerId").focus();
  					}
  					else if(response.code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
						$("#sellerId").focus();
					}
  					else
  					{
  						alert("오류가 발생하였습니다.");
  						$("#userId").focus();
  					}
  				},
  				error:function(xhr, status, error)
  				{
  					icia.common.error(error);
  				}
  			});
  		});	
  		
  	});
  	
  	//사업자 등록번호 체크
  	function checkBusinessNumber() {
  	    var sellNumber = $("#sellerSellnumber").val().replace(/-/g, "");

  	    if (!/^\d{10}$/.test(sellNumber)) {
  	        alert("사업자등록번호는 숫자 10자리여야 합니다.");
  	        return false;
  	    }

  	    var multipliers = [1, 3, 7, 1, 3, 7, 1, 3, 5];
  	    var sum = 0;

  	    for (var i = 0; i < 9; i++) {
  	        sum += parseInt(sellNumber.charAt(i)) * multipliers[i];
  	    }

  	    sum += Math.floor((parseInt(sellNumber.charAt(8)) * 5) / 10);
  	    var checkDigit = (10 - (sum % 10)) % 10;

  	    if (checkDigit !== parseInt(sellNumber.charAt(9))) {
  	        alert("유효하지 않은 사업자등록번호입니다.");
  	        return false;
  	    }

  	    return true;
  	}
  	
  	function fn_userReg()
  	{
  		var form = $("#sellerRegForm")[0];
		var formData = new FormData(form);		//자바스크립트에서 폼 데이터를 다루는 객체
		
  		$.ajax({
  			type:"POST",
			url:"/seller/sellerRegProc",
			data:{
				sellerId:$("#sellerId").val(),
				sellerPassword2:$("#sellerPassword2").val(),
				sellerName:$("#sellerName").val(),
				sellerNumber:$("#sellerNumber").val(),
				sellerEmail:$("#sellerEmail").val(),
				sellerBusiness:$("#sellerBusiness").val(),
				sellerSellnumber:$("#sellerSellnumber").val(),
			},
			datatype:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");
			},
  			success:function(response)
  			{
  				if(response.code == 0)
  				{
  					alert("판매자 가입이 되었습니다.");
  					location.href = "/seller/login";
  				}
  				else if(response.code == 100)
  				{
  					alert("판매자 아이디가 중복되었습니다.");
  					$("#sellerId").focus();
  				}
  				else if(response.code == 400)
  				{
  					alert("파라미터 값이 올바르지 않습니다.");
  					$("#sellerId").focus();
  				}
  				else if(response.code == 500)
  				{
  					alert("판매자 가입 중 오류가 발생하였습니다.");
  					$("#sellerId").focus();
  				}
  				//else
  				//{
  				//	alert("판매자 가입 중 알수없는 오류가 발생하였습니다.");
  				//	$("#sellerId").focus();
  				//}
  			},
  			error:function(xhr, status, error)
  			{
  				icia.common.error(error);
  			}
  			
  		});
  	}

  	function fn_validateEmail(value)
  	{
  		var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
  		
  		return emailReg.test(value);
  	}
  	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  <div class="signup-container">
    <h2>판매자등록</h2>
    <form id="sellerRegForm" method="post">
      
      <div class="form-group">
        <label>판매자 아이디 </label>
        <input type="text" id="sellerId" name="sellerId" maxlength="20">
      </div>

      <div class="form-group">
        <label>비밀번호</label>
        <input type="password" id="sellerPassword1" name="sellerPassword1" maxlength="20">
      </div>
      
      <div class="form-group">
        <label>비밀번호 확인</label>
        <input type="password" id="sellerPassword2" name="sellerPassword2" maxlength="20">
      </div>
 

      <div class="form-group">
        <label>판매자 이름</label>
        <input type="text" id="sellerName" name="sellerName" maxlength="20">
      </div>
      
      <div class="form-group">
        <label>전화번호</label>
        <input type="text" id="sellerNumber" name="sellerNumber" placeholder="예: 010-1234-5678">
      </div>
      
	  <div class="form-group">
	      <label>이메일</label>
	      <input type="email" id="sellerEmail" name="sellerEmail">
	  </div>
	  
	    <div class="form-group">
	      <label>상호명</label>
	      <input type="text" id="sellerBusiness" name="sellerBusiness">
	  </div>
	  
	  <div class="form-group">
	      <label>사업자등록번호</label>
	      <input type="text" id="sellerSellnumber" name="sellerSellnumber" placeholder="예:123-45-67890">
	  </div>

      <button type="button" id="btnReg" class="submit-btn">가입하기</button>
    </form>
  </div>
</body>
</html>
    