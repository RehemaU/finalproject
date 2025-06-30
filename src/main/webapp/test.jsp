<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>글 목록 + 썸네일</title>
  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"/>
  <style>
.thumb {
  width: 150px;
  height: 150px;
  overflow: hidden;
  border-radius: 50px;   /* 모서리를 12px만큼 둥글게 */
  flex-shrink: 0;
}
.square-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  /* 필요하면 이미지에도 살짝 라운드 추가 가능 */
  border-radius: 8px;
}
  </style>
</head>
<body class="bg-light">
  <div class="container py-5">
    <h1 class="mb-4">글과 썸네일 리스트</h1>

    <!-- 반복 예시: 하나당 .d-flex 컨테이너 하나 -->
    <div class="d-flex align-items-start mb-4">
      <!-- 이미지 -->
      <div class="thumb me-3">
        <img src="\resources\editorupload\127315d2-83e5-4ad5-b628-5cebcc9507f9.jpg"
             alt="썸네일" class="square-img"/>
      </div>
      <!-- 텍스트 -->
      <div>
        <h5>첫 번째 글 제목</h5>
        <p>여기에 이미지 옆에 들어갈 본문 내용이 표시됩니다. 예를 들어 간단한 설명이나 글 요약 등을 넣을 수 있어요.</p>
      </div>
    </div>

    <div class="d-flex align-items-start mb-4">
      <div class="thumb me-3">
        <img src="\resources\editorupload\49f0fafb-9c3b-4329-8ec7-30dd176306d4.png"
             alt="썸네일" class="square-img"/>
      </div>
      <div>
        <h5>두 번째 글 제목</h5>
        <p>두 번째 이미지 옆에 들어갈 텍스트 예시입니다.</p>
      </div>
    </div>

    <!-- ... 반복 ... -->

  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
