<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>PDF 워크스루</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 20px;
    }

    h2 {
      font-size: 24px;
      margin-bottom: 20px;
    }

    iframe {
      width: 100%;
      height: 800px;
      border: 1px solid #ccc;
    }

    .pdf-link {
      display: inline-block;
      margin-bottom: 20px;
      color: #0066cc;
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <h2>PDF 사용 가이드 보기</h2>

  <a class="pdf-link" href="/web/viewer.html?file=samplepdf.pdf" target="_blank">새 창으로 보기</a>

  <iframe src="/web/viewer.html?file=samplepdf.pdf"></iframe>

</body>
</html>
