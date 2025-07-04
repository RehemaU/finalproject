<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>결제 성공</title></head>
<body>
<p>결제가 완료되었습니다. 창을 닫습니다...</p>
<script>
    if (window.opener) {
        window.opener.location.href = "/order/kakao/complete"; // 부모 창 이동
        window.close(); // 팝업 닫기
    } else {
        alert("결제 완료! 창을 닫아주세요.");
    }
</script>
</body>
</html>