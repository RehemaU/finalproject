<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>후기 작성</title>

  <!-- Toast UI Editor CSS -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

  <!-- ✅ 커스텀 스타일 -->
  <style>
  
	/* “제출” 버튼을 블랙 CTA 스타일로 변경 */
	#submitBtn{
	  background:#000;          /* 검정 배경 */
	  color:#fff;               /* 흰색 글씨 */
	  border:none;
	  border-radius:12px;       /* 둥근 모서리 */
	  padding:14px 48px;        /* 위아래 / 좌우 여백 */
	  font-size:18px;
	  font-weight:700;
	  cursor:pointer;
	  display:block;            /* 가운데 정렬용 */
	  margin:0 auto 20px;       /* 위는 0, 아래는 20px */
	  
	  transition:all .2s ease;  /* 호버 부드럽게 */
	}
	
	#submitBtn:hover{
	  transform:translateY(-2px);               /* 살짝 띄우기 */
	  box-shadow:0 6px 12px rgba(0,0,0,.35);    /* 그림자 */
	}
	
	#submitBtn:active{
	  transform:translateY(0);
	  box-shadow:none;
	}
  
  
    /* 페이지 전체 가운데 정렬 */
    h1            { text-align: center; margin-top: 40px; }

    /* 입력‧에디터 감싸는 래퍼 */
    .review-container {
      width: 100%;          /* ← 여기 숫자만 바꾸면 폭 조정 가능 */
      max-width: 1300px;    /* 너무 넓어지지 않게 */
      margin: 0 auto;      /* 가운데 정렬 */
    }

    /* 제목 입력칸 */
    .review-container input[type="text"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      margin-bottom: 15px;
    }

    /* 에디터 외곽·내부 모두 폭 100% */
    #editor,
    .toastui-editor-defaultUI { width: 100% !important; }

    #editor            { margin-bottom: 20px; }
    #submitBtn         { display: block; margin: 0 auto 20px; }
    #resultMessage     { text-align: center; margin-top: 15px; font-weight: bold; }
    
  </style>

</head>