<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
  <title>회원정보수정</title>
 <style>
  :root{
    --fg:#000;            /* 텍스트 - 블랙 */
    --bg:#ffffff;         /* 배경 - 화이트 */
    --border:#e5e5e5;     /* 연한 회색선 */
    --radius:12px;        /* 둥근 정도 */
    --primary:#000000;    /* 액션·포인트 컬러 = 블랙 */
  }

  /* 레이아웃 ─────────────────────────── */
  body{
    margin:0;
    background:var(--bg);
    color:var(--fg);
    font-family:'Pretendard', sans-serif;
    font-size:15px;
    line-height:1.5;
  }
  .signup-container{
    max-width:520px;
    margin:80px auto;
    padding:56px 60px;
    border:1px solid var(--border);
    border-radius:var(--radius);
    background:#fff;
    box-shadow:0 4px 20px rgba(0,0,0,.05);
  }
  .signup-container h2{
    font-size:28px;
    font-weight:700;
    text-align:center;
    margin-bottom:44px;
    letter-spacing:-.4px;
  }

  /* 폼 그룹 ──────────────────────────── */
  .form-group{margin-bottom:28px;display:flex;flex-direction:column;gap:10px}
  label{font-size:15px;font-weight:600}

  /* 입력·셀렉트·파일 */
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
  input[readonly]{background:#f5f5f5;color:#888;cursor:not-allowed}

  /* 주소 검색 영역 */
  .address-group{gap:18px}
  .address-group button{
    height:46px;
    padding:0 26px;
    border:none;
    border-radius:var(--radius);
    background:var(--primary);
    color:#fff;
    font-weight:600;
    cursor:pointer;
    transition:opacity .15s;
  }
  .address-group button:hover{opacity:.85}

  /* 프로필 이미지 썸네일 */
  .form-group img{
    width:80px;height:80px;object-fit:cover;
    border-radius:6px;border:1px solid var(--border);
  }

  /* date 입력을 YYYYMMDD 포맷으로 바꾼 뒤에도 동일 스타일 유지 */
  input[type="date"],
  input[type="text"][id="userBirth"]{
    appearance:none;
    -webkit-appearance:none;
  }

  /* 제출 버튼 ────────────────────────── */
  .submit-btn{
    width:100%;
    padding:16px 0;
    margin-top:36px;
    font-size:16px;
    font-weight:700;
    background:var(--primary);
    color:#fff;
    border:none;
    border-radius:var(--radius);
    cursor:pointer;
    transition:opacity .15s;
  }
  .submit-btn:hover{opacity:.85}
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
  			
  			//var userAdd = $.trim($("#userAdd").val());
  			
  			//if (!addressCheck.test(userAdd)) 
  			//{
  			//  alert("주소는 한글/영문/숫자 조합으로 5자 이상 입력해야 합니다.");
  			//  $("#userAdd").focus();
  			//  return;
  			//}
  			
  			
  			var birth = $.trim($("#userBirth").val());
  			var birthCheck = /^\d{8}$/;

  			if (!birthCheck.test(birth)) 
  			{
  			  alert("생년월일은 YYYYMMDD 형식의 8자리 숫자로 입력하세요.");
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
  			
  		});	
  		
  		$("#btnUpdate").on("click", function(){
  			var form = $("#updateForm")[0];
  			var formData = new FormData(form);		//자바스크립트에서 폼 데이터를 다루는 객체
			
  			$.ajax({
  				type:"POST",
  				enctype:"multipart/form-data",
  				url:"/user/userUpdateProc",
  				data:formData,
  				processData:false,
  				contentType:false,
  				cache:false,
  				beforeSend:function(xhr)
  				{
  					xhr.setRequestHeader("AJAX", "true");
  				},
  				success:function(response)
  	  			{
  	  				if(response.code == 0)
  	  				{
  	  					alert("회원정보가 수정되었습니다.");
  	  					location.href = "/user/userUpdateForm";
  	  				}
  	  				else if(response.code == 400)
  	  				{
  	  					alert("파라미터 값이 올바르지 않습니다.");
  	  					$("#userId").focus();
  	  				}
  	  				else if(response.code == 404)
  	  				{
  	  					alert("회원정보가 존재하지 않습니다.");
  						location.href = "/user/login";
  	  				}
  	  				else if(response.code == 410)
  	  				{
  	  					alert("로그인을 먼저 하세요.");
  						location.href = "/user/login";
  	  				}
  	  				else if(response.code == 430)
  	  				{
  	  					alert("아이디 정보가 다릅니다.");
  						location.href = "/user/login";
  	  				}
  	  				else if(response.code == 500)
  	  				{
  	  					alert("회원정보 수정 중 오류가 발생하였습니다.");
  						$("#userId").focus();
  	  				}
  	  				else
  	  				{
  	  					alert("회원정보 수정 중 오류 발생");
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
    <h2>회원정보수정</h2>

    <form id="updateForm" name="updateForm" method="post" enctype="multipart/form-data">
      <div class="form-group">
	  <c:if test="${!empty user.userProfile}">
	    <!-- 이미지가 있을 때만 label + 이미지 표시 -->
	    <div style="display: flex; align-items: center; gap: 10px;">
	      <label style="margin: 0;">프로필 사진</label>
	      <img src="/resources/upload/${user.userId}.${userProfile}"
	           style="width: 80px; height: 80px; object-fit: cover; border-radius: 5px; border: 1px solid #ccc;" />
	    </div>
	  </c:if>
	  	프로필 파일변경<input type="file" id="userProfile" name="userProfile">
        <c:if test="${!empty user.userProfile}">
		    <div style="margin-bottom:0.3em;">[첨부파일 : ${user.userId}.${user.userProfile}]</div>
        </c:if>
	</div>
	
      <div class="form-group">
        <label>아이디</label>
        <input type="text" id="userId" name="userId" value="${user.userId}" maxlength="20" readonly>
      </div>

      <div class="form-group">
        <label>이름</label>
        <input type="text" id="userName" name="userName" value="${user.userName}" maxlength="20">
      </div>

      <div class="form-group">
        <label>성별</label>
        <select id="userGender" name="userGender" value="${user.userGender}">
          <option value="">선택</option>
          <option value="M" <c:if test="${user.userGender == 'M'}">selected</c:if>>남자</option>
          <option value="F" <c:if test="${user.userGender == 'F'}">selected</c:if>>여자</option>
        </select>
      </div>
      
      <div class="form-group">
        <label>전화번호</label>
        <input type="text" id="userNumber" name="userNumber" value="${user.userNumber}" placeholder="예: 010-1234-5678">
      </div>
        
    <div class="form-group address-group">
      <label>우편번호</label>
       <div style="display: flex; align-items: center; gap: 6px; margin-top: 4px;">
      	 <input type="text" id="zipCode" name="zipCode" placeholder="우편번호" value="${zipCode}" readonly onclick="execPostCode()" style="width: 120px;">
     	 <button type="button" onclick="execPostCode()"
            style="height: 45px; padding: 0 20px;">검색</button>
       </div>
      <label>도로명 주소</label>
      <input type="text" id="streetAdr" name="streetAdr" placeholder="도로명 주소" value="${streetAdr}" readonly>

      <label>상세 주소</label>
      <input type="text" id="detailAdr" name="detailAdr" placeholder="상세 주소" value="${detailAdr}" onclick="addrCheck()">
    </div>
      
      <!-- <div class="form-group">//-->
      <div class="form-group">
      <label>생년월일</label>
      <!--<input type="date" id="userBirth" name="userBirth"  value="${user.userBirth}" placeholder="YYYYMMDD" onchange="formatBirthDate(this)">//-->
      <c:choose>
    	<c:when test="${not empty user.userBirth}">
      		<input type="date" id="userBirth" name="userBirth"
             	value="${user.userBirth.substring(0,4)}-${user.userBirth.substring(4,6)}-${user.userBirth.substring(6,8)}"
             	onchange="formatBirthDate(this)" maxlength="8">
    	</c:when>
      <c:otherwise>
      	<input type="date" id="userBirth" name="userBirth" onchange="formatBirthDate(this)"> 	
     </c:otherwise>
  </c:choose>
    </div>
    
     <div class="form-group">
      <label>이메일</label>
      <input type="email" id="userEmail" name="userEmail" value="${user.userEmail}" maxlength="25">
     </div>
    
      <!--<div class="form-group">
        <label>프로필 사진</label>
        <input type="file" id="userProfile" name="userProfile">
        <c:if test="${!empty user.userProfile}">
		    <div style="margin-bottom:0.3em;">[첨부파일 : ${user.userId}.${user.userProfile}]</div>
        </c:if>
      </div>//-->
      
<div style="text-align: center;">
      <button type="button" id="btnUpdate" class="submit-btn">수정하기</button>
      <button type="button" id="btnWithdrawal" class="submit-btn" style="width:30%; background-color: gray;">회원탈퇴</button>
</div>
    </form>
  </div>

<script>
document.getElementById("btnWithdrawal").addEventListener("click", function(){
	
	const userId = "${user.userId}";
	
	if(confirm("정말로 탈퇴하시겠습니까?"))
	{
	fetch("/user/userWithdrawal", {
		  method: "POST", // 또는 "GET"
		  headers: {
		    "Content-Type": "application/x-www-form-urlencoded" // 또는 "application/json"
		  },
		  body: "userId=" + encodeURIComponent(userId) // POST일 때만 사용
		})
		.then(res => res.json())  // 또는 res.text(), res.blob()
		.then(data => {
		  console.log("응답 결과:", data);
		  if(data.code == 0)
		  {
			  alert("회원 탈퇴되었습니다.");
			  location.href = "/user/loginOut";
		  }
		  else
		  {
			  alert("처리 도중 문제가 발생하였습니다.");
			  location.reload();
		  }
		})
		.catch(err => {
		  console.error("에러 발생:", err);
		});
	}
	
});

</script>

</body>
</html>
    