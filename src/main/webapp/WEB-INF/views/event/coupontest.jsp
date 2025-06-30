<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>쿠폰 발급 테스트</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>쿠폰 발급 테스트 페이지</h2>

    <button id="btnIssueCoupon">쿠폰 발급받기</button>

    <script>
        $(document).ready(function() {
            $("#btnIssueCoupon").click(function() {
                $.ajax({
                    type: "POST",
                    url: "/event/issueCoupon",
                    data: {
                        eventId: "EVT006" // 테스트용 eventId
                    },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("AJAX", "true");
                    },
                    success: function(res) {
                        if (res.code === 0) {
                            alert("✅ " + res.msg);
                            // 컨트롤러에서 내려준 redirectUrl이 있으면 해당 위치로 이동
                            if (res.data && res.data.redirectUrl) {
                                window.location.href = res.data.redirectUrl;
                            } else {
                                location.reload(); // 혹시 redirectUrl이 누락되었을 경우 대비
                            }
                        } else {
                            alert("⚠️ " + res.msg);
                        }
                    },
                    error: function(xhr) {
                        alert("❌ 서버 오류 발생: " + xhr.status);
                    }
                });
            });
        });
    </script>
</body>
</html>
