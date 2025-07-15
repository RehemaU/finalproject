<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
  <title>회원가입</title>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
  	$(document).ready(function(){
  		$("#userId").focus();
  		
  		$("#btnReg").on("click",function(){
  			//공백체크
  			var emptCheck = /\s/g;
  			
  			//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
  			var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
  			
  			// 010-1234-5678 또는 01012345678 형식 허용
  			var phoneCheck = /^01[016789]-?\d{3,4}-?\d{4}$/;
  			
  			// 한글, 영어, 숫자, 공백, 일부 특수문자(-, .) 허용 / 최소 5자 이상
  			var addressCheck = /^[가-힣a-zA-Z0-9\s\-\.\,]{5,100}$/;
  			
  			if($.trim($("#userId").val()).length <= 0)
  			{
  				alert("회원 아이디를 입력하세요.");
  				$("#userId").val("");
  				$("#userId").focus();
  				return;
  			}
  			
  			if(emptCheck.test($("#userId").val()))
  			{
  				alert("회원 아이디는 공백을 포함할수 없습니다.");
  				$("#userId").focus();
  				return;
  			}
  			
  			if(!idPwCheck.test($("#userId").val()))
  			{
  				alert("회원 아이디는 4~12자의 영문 대소문자와 숫자로만 입력가능합니다.");
  				$("#userId").val("");
  				$("#userId").focus();
  				return;
  			}
  			
  			if($.trim($("#userPassword1").val()).length <= 0)
  			{
  				alert("비밀번호를 입력하세요.");
  				$("#userPassword1").val("");
  				$("#userPassword1").focus();
  				return;
  			}
  			
  			if(!idPwCheck.test($("#userPassword1").val()))
  			{
  				alert("비밀번호는 영문 대소문자 숫자로 4~12자리로 입력가능합니다.");
  				$("#userPassword1").val("");
  				$("#userPassword1").focus();
  				return;
  			}
  			
  			if($.trim($("#userPassword2").val()).length <= 0)
			{
				alert("비밀번호 확인을 입력하세요.");
				$("#userPassword2").val("");
  				$("#userPassword2").focus();
  				return;
			}
  			
  			if($("#userPassword1").val() != $("#userPassword2").val())
  			{
  				alert("비밀번호가 일치하지 않습니다.");
  				$("#userPassword2").focus();
  				return;
  			}
  			
  			$("#userPassword").val($("#userPassword1").val());
  			
  			if($.trim($("#userName").val()).length <= 0)
  			{
  				alert("회원 이름을 입력하세요");
  				$("#userName").val("");
  				$("#userName").focus();
  				return;			
  			}
  			
  			if($("#userGender").val() == "")
  			{
  				alert("성별을 선택하세요");
  				$("#userGender").focus();
  				return;
  			}
  			
  			var userPhone = $.trim($("#userNumber").val());
  			if (!phoneCheck.test(userPhone)) {
  			  alert("전화번호는 010-1234-5678 형식으로 입력하세요.");
  			  $("#userNumber").focus();
  			  return;
  			}
  			
  		    
  		  	if ($.trim($("#zipCode").val()).length <= 0) {
  		      alert("우편번호를 선택해주세요.");
  		      $("#zipCode").focus();
  		      return;
  		    }
  		  	
  		  	if ($("#streetAdr").val().trim().length <= 0) {
  		      alert("도로명 주소를 입력해주세요.");
  		      $("#streetAdr").focus();
  		      return;
  		    }
  			
  			
  			var birth = $.trim($("#userBirth").val());
  			var birthCheck = /^\d{8}$/;

  			if (!birthCheck.test(birth)) 
  			{
  			  alert("생년월일은 YYYYMMDD 형식의 8자리 숫자로 입력하세요.");
  			  $("#userBirth").val("");
  			  $("#userBirth").focus();
  			  return;
  			}
  			
  			if($.trim($("#userEmail").val()) <= 0)
  			{
  				alert("회원 이메일을 입력하세요.");
  				$("#userEmail").val("");
  				$("#userEmail").focus();
  				return;
  			}
  			
  			if(!fn_validateEmail($("#userEmail").val()))
  			{
  				alert("회원 이메일 형식이 올바르지 않습니다.");
  				$("#userEmail").focus();
  				return;
  			}
  			//중복아이디 체크 aJax
  			$.ajax({
  				type:"POST",
  				url:"/user/idCheck",
  				data:{
  					userId:$("#userId").val()
  				},
  				datatype:"JSON",
  				beforesend:function(xhr)
  				{
  					xhr.setRequestHeader("AJAX", "true");
  				},
  				success:function(response)
  				{
  					if(response.code == 0)
  					{
  						alert("회원가입이 가능합니다.");
  						fn_userReg();
  					}
  					else if(response.code == 100)
  					{
  						alert("중복아이디 입니다.");
  						$("#userId").focus();
  					}
  					else if(response.code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
						$("#userId").focus();
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
  	
  	function fn_userReg()
  	{
  		var form = $("#userRegForm")[0];
		var formData = new FormData(form);		//자바스크립트에서 폼 데이터를 다루는 객체
  		
		
  		$.ajax({
  	        type:"POST",
			enctype:"multipart/form-data",
			url:"/user/userRegProc",
			data:formData,
			processData:false,		//formData를 string으로 변환하지 않음.
			contentType:false,		//content-type헤더가 multipart/form-data로 전송
			cache:false,
			timeout:600000,
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");
			},
  			success:function(response)
  			{
  				if(response.code == 0)
  				{
  					alert("회원가입이 되었습니다.");
  					location.href = "/user/login";
  				}
  				else if(response.code == 100)
  				{
  					alert("회원 아이디가 중복되었습니다.");
  					$("#userId").focus();
  				}
  				else if(response.code == 400)
  				{
  					alert("파라미터 값이 올바르지 않습니다.");
  					$("#userId").focus();
  				}
  				else if(response.code == 500)
  				{
  					alert("회원가입 중 오류가 발생하였습니다.");
  					$("#userId").focus();
  				}
  				else
  				{
  					alert("회원 가입 중 알수없는 오류가 발생하였습니다.");
  					$("#userId").focus();
  				}
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
  	
  	 function execPostCode()
  	 {
       new daum.Postcode({
           oncomplete: function(data) {
           	// 우편번호
               $("#zipCode").val(data.zonecode);
               // 도로명 및 지번주소
               $("#streetAdr").val(data.roadAddress);
           }
       }).open();
  	 } 
  	    
	function addrCheck() 
	{
        if($("#zipCode").val() == '' && $("#streetAdr").val() == ''){
            alert("우편번호를 클릭하여 주소를 검색해주세요.");
            $("#zipCode").focus();
        }
    }
	
	function formatBirthDate(el) {
	   var value = el.value; // 예: 2025-06-24
	    if (value) {
	      var formatted = value.replace(/-/g, ''); // 20250624
	      el.type = "text"; // type을 text로 바꾸면 변경된 값 표시 가능
	      el.value = formatted;
	    }
	  }
  	</script>
  	 <!-- 우편번호 daum api -->
  	 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  	 
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  <div class="signup-container">
    <h2>회원가입</h2>
    <form id="userRegForm" name="userRegForm" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label>아이디 </label>
        <input type="text" id="userId" name="userId" maxlength="20">
      </div>

      <div class="form-group">
        <label>비밀번호</label>
        <input type="password" id="userPassword1" name="userPassword1" maxlength="20">
      </div>
      
      <div class="form-group">
        <label>비밀번호 확인</label>
        <input type="password" id="userPassword2" name="userPassword2" maxlength="20">
      </div>
 

      <div class="form-group">
        <label>이름</label>
        <input type="text" id="userName" name="userName" maxlength="20">
      </div>

      <div class="form-group">
        <label>성별</label>
        <select id="userGender" name="userGender">
          <option value="">선택</option>
          <option value="M">남자</option>
          <option value="F">여자</option>
        </select>
      </div>
      

      <div class="form-group">
        <label>전화번호</label>
        <input type="text" id="userNumber" name="userNumber" placeholder="예: 010-1234-5678">
      </div>
      
  
      
    <div class="form-group address-group">
      <label>우편번호</label>
      <!--<input type="text" id="zipCode" name="zipCode" placeholder="우편번호" readonly onclick="execPostCode()">//-->
      <div style="display: flex; align-items: center; gap: 6px; margin-top: 4px;">
      	 <input type="text" id="zipCode" name="zipCode" placeholder="우편번호" value="${zipCode}" readonly onclick="execPostCode()" style="width: 120px;">
     	 <button type="button" onclick="execPostCode()"
            style="height: 45px; padding: 0 20px;">검색</button>
      </div>

      <label>도로명 주소</label>
      <input type="text" id="streetAdr" name="streetAdr" placeholder="도로명 주소" readonly>

      <label>상세 주소</label>
      <input type="text" id="detailAdr" name="detailAdr" placeholder="상세 주소" onclick="addrCheck()">
    </div>

      <!--<div class="form-group">
        <label>주소</label>
        <input type="text" id="userAdd" name="userAdd">
      </div>//-->
      
      <div class="form-group">
      <label>생년월일</label>
      <input type="date" id="userBirth" name="userBirth" placeholder="YYYYMMDD" onchange="formatBirthDate(this)">
    </div>

    <div class="form-group">
      <label>이메일</label>
      <input type="email" id="userEmail" name="userEmail">
    </div>

      <div class="form-group">
        <label>프로필 사진</label>
        <input type="file" id="userProfile" name="userProfile">
      </div>

      <button type="button" id="btnReg" class="submit-btn">가입하기</button>
      <input type="hidden" id="uniqueId" name="uniqueId" value="${uniqueId}">
      <input type="hidden" id="regType" name="regType" value="${regType}">
    </form>
  </div>
</body>
</html>
    