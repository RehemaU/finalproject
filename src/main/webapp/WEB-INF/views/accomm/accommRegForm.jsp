<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
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

  <script type="text/javascript">
  	
  	
  function execPostCode()
  {
    new daum.Postcode({
        oncomplete: function(data) {
        	// 우편번호 
        	//alert(data.zonecode);
            $("#zipCode").val(data.zonecode);
            // 도로명 및 지번주소
            //alert(data.roadAddress);
            $("#streetAdr").val(data.roadAddress);
            
            $.ajax({
                type: "POST",
                url: "/accomm/regionSelect",
                data: {
                  zipCode: data.zonecode,                // 또는 $("#zipCode").val()
    			  streetAdr: data.roadAddress            // 또는 $("#streetAdr").val()
                },
                dataType: "json",  // 컨트롤러에서 JSON 응답 시 사용
                success: function(response) 
                {
               	  if (response.code === 0 && response.data) {
               		
               		let regionId = response.data.regionId;
                    $("#regionId").val(regionId);
                    
                    $.ajax({
                        type: "POST",
                        url: "/accomm/sigunguSelect",
                        data: {
                          zipCode: data.zonecode,                
            			  streetAdr: data.roadAddress, 
            			  regionId : $("#regionId").val()
                        },
                        dataType: "json",  // 컨트롤러에서 JSON 응답 시 사용
                        success: function(response) 
                        {
                       	  if (response.code === 0 && response.data) {
                       	      $("#sigunguId").val(response.data.sigunguId);
                       	  } else {
                       	      alert("시군구 코드 조회 실패: " + response.message);
                       	  }
                         },
                        error: function(xhr, status, error) {
                          alert("서버 오류 발생: " + error);
                        }
                    });
               	  } else {
               	      alert("지역 코드 조회 실패: " + response.message);
               	 }
               },
               error: function(xhr, status, error) {
                 alert("서버 오류 발생: " + error);
               }
           });
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
	
  	</script>
  	 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	 <!-- 우편번호 daum api -->
  	 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  	 
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation2.jsp" %>
  <div class="signup-container">
    <h2>숙소등록</h2>
    <form id="userRegForm" name="userRegForm" method="post">
      
      <div class="form-group">
        <label>지역코드</label>
        <input type="text" id="regionId" name="regionId"  maxlength="20">
      </div>
      
      <div class="form-group">
        <label>시군구코드</label>
        <input type="text" id="sigunguId" name="sigunguId"  maxlength="20">
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

    
      <div class="form-group">
        <label>숙소첨부</label>
        <input type="file" id="userProfile" name="userProfile">
      </div>

      <button type="button" id="btnReg" class="submit-btn">숙소등록</button>
    </form>
  </div>
</body>
</html>
    