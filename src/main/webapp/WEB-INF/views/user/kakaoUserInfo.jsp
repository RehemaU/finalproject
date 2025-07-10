<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>카카오 사용자 정보</title></head>
<body>
    <h2>카카오 로그인 성공!</h2>
    <p>닉네임: ${userName}</p>
    
    <!--<c:if test="${not empty sessionScope.kakao_access_token}">
    <a href="/user/kakaoLogout">로그아웃</a>
	</c:if>  -->
	
	<c:when test="${not empty sessionScope.kakao_access_token}">
    <!--<p>${userName} 님 환영합니다! <a href="https://kauth.kakao.com/oauth/logout?client_id=80e4419557c7b5feaa6bcbaa1cae6ae8&logout_redirect_uri=http://finalproject.sist.co.kr:8088/user/kakaoLogout">로그아웃</a></p>-->
    <p>${userName} 님 환영합니다! <a href="/user/loginOut">로그아웃</a></p>
    </c:when>
    
</body>
</html>