<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/userHead.jsp" %>
  <title>판매자등록</title>
  <style>
    .signup-container {
    max-width: 400px;
    margin: 0 auto;
    padding: 30px;
    border: 1px solid #ddd;
    border-radius: 10px;
    font-family: 'Arial', sans-serif;
    background-color: #fff;
  }

  .signup-container h2 {
    text-align: center;
    margin-bottom: 30px;
  }

  .form-group {
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
  }

  label {
    font-weight: bold;
    margin-bottom: 5px;
  }

  input[type="text"],
  input[type="password"],
  input[type="email"],
  input[type="file"],
  select {
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 6px;
  }

  input[readonly] {
    background-color: #f5f5f5;
    cursor: not-allowed;
  }

  .address-group {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .submit-btn {
    width: 100%;
    padding: 12px;
    font-size: 16px;
    background-color: #2d7df6;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    margin-top: 20px;
  }

  .submit-btn:hover {
    background-color: #135fd4;
  }
 
  </style>
  <script type="text/javascript">
  	$(document).ready(function(){
  		$("#sellerId").focus();
  		
  		$("#btnUpdate").on("click",function(){
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
  			
  			fn_sellerReg();
  			
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
  	
  	function fn_sellerReg()
  	{
  		var form = $("#sellerUpdateForm")[0];
		var formData = new FormData(form);		//자바스크립트에서 폼 데이터를 다루는 객체
		
  		$.ajax({
  			type:"POST",
			url:"/seller/sellerUpdateProc",
			data:{
				sellerId:$("#sellerId").val(),
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
  					alert("판매자 정보가 수정되었습니다.");
  					location.href = "/seller/sellerUpdateForm";
  				}
  				else if(response.code == 400)
  				{
  					alert("파라미터 값이 올바르지 않습니다.");
  					$("#sellerId").focus();
  				}
  				else if(response.code == 404)
  				{
  					alert("판매자정보가 존재하지 않습니다.");
					location.href = "/seller/login";
  				}
  				else if(response.code == 410)
  				{
  					alert("로그인을 먼저 하세요.");
					location.href = "/seller/login";
  				}
  				else if(response.code == 430)
  				{
  					alert("아이디 정보가 다릅니다.");
					location.href = "/seller/login";
  				}
  				else if(response.code == 500)
  				{
  					alert("판매자정보 수정 중 오류가 발생하였습니다.");
  					$("#sellerId").focus();
  				}
  				else
  				{
  					alert("판매자정보 수정 중 오류 발생");
					$("#sellerId").focus();
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
  	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation2.jsp" %>
  <div class="signup-container">
    <h2>판매자수정</h2>
    <form id="sellerUpdateForm"  method="post">
      
      <div class="form-group">
        <label>판매자 아이디 </label>
        <input type="text" id="sellerId" name="sellerId"  value="${seller.sellerId}"  maxlength="20" readonly>
      </div>
 
      <div class="form-group">
        <label>판매자 이름</label>
        <input type="text" id="sellerName" name="sellerName" value="${seller.sellerName}" maxlength="20" readonly>
      </div>
      
      <div class="form-group">
        <label>전화번호</label>
        <input type="text" id="sellerNumber" name="sellerNumber" value="${seller.sellerNumber}" placeholder="예: 010-1234-5678">
      </div>
      
	  <div class="form-group">
	      <label>이메일</label>
	      <input type="email" id="sellerEmail" name="sellerEmail" value="${seller.sellerEmail}">
	  </div>
	  
	    <div class="form-group">
	      <label>상호명</label>
	      <input type="text" id="sellerBusiness" name="sellerBusiness" value="${seller.sellerBusiness}">
	  </div>
	  
	  <div class="form-group">
	      <label>사업자등록번호</label>
	      <input type="text" id="sellerSellnumber" name="sellerSellnumber" value="${seller.sellerSellnumber}" >
	  </div>

      <button type="button" id="btnUpdate" class="submit-btn">수정하기</button>
    </form>
  </div>
</body>
</html>
    