<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/include/head.jsp" %> <%-- 공통 head (폰트, 변수 등) --%>

<body class="page">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 네비게이션 --%>

<main class="wrap">
  <section style="max-width: 980px; margin: 0 auto; padding: 40px 20px;">
    <h2 style="font-size: 28px; font-family: 'Noto Sans KR', sans-serif'', serif; margin-bottom: 20px; color: #000;">마이트립 사용 가이드</h2>

    <a class="pdf-link" href="/resources/pdf/web/viewer.html?file=samplepdf.pdf" target="_blank"
       style="display:inline-block; margin-bottom:20px; padding:10px 16px; background:#000; color:#fff; text-decoration:none; border-radius:6px;">
       전체화면으로 보기
    </a>

    <iframe src="/resources/pdf/web/viewer.html?file=samplepdf.pdf"
            style="width: 100%; height: 800px; border: 1px solid #ddd; border-radius: 8px;"></iframe>
  </section>
</main>

</body>
</html>
