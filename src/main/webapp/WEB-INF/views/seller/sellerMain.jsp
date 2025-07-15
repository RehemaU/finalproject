<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/sellerHead2.jsp" %>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>셀러 메인</title>
  <style>
    .main-content {
      flex: 1;
      padding: 40px 60px;
      background-color: #fff;
    }

    .main-title {
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 32px;
      border-left: 4px solid #000;
      padding-left: 12px;
    }

    .card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 24px;
    }

    .card {
      background: #fff;
      border: 1px solid #ddd;
      padding: 24px;
      border-radius: 12px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
      transition: box-shadow 0.2s, transform 0.2s;
    }

    .card:hover {
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
      transform: translateY(-4px);
    }

    .card h3 {
      font-size: 16px;
      margin-bottom: 10px;
    }

    .card p {
      font-size: 14px;
      color: #555;
      margin-bottom: 20px;
    }

    .card a {
      display: inline-block;
      padding: 8px 16px;
      border: 1px solid #000;
      border-radius: 24px;
      text-decoration: none;
      font-size: 14px;
      color: #000;
      font-weight: 500;
      transition: background 0.2s, color 0.2s;
    }

    .card a:hover {
      background: #000;
      color: #fff;
    }
  </style>
</head>
<body>

  <main class="main-content">
    <div class="main-title">셀러 대시보드</div>

    <div class="card-grid">
      <div class="card">
        <h3>숙소 등록</h3>
        <p>새로운 숙소를 등록하고 상세정보를 입력하세요.</p>
        <a href="/accomm/accommRegForm">등록하기</a>
      </div>

      <div class="card">
        <h3>숙소 목록</h3>
        <p>등록된 숙소들을 확인하고 수정/삭제할 수 있습니다.</p>

        <a href="/seller/accommList">목록 보기</a>
      </div>

      <div class="card">	
        <h3>객실 등록</h3>
        <p>숙소에 객실을 추가하고 가격, 수량 등을 설정하세요.</p>
        <a href="/accomm/accommRoomRegForm">객실 등록</a>
      </div>

      <div class="card">
        <h3>정산 내역</h3>
        <p>예약된 내역과 정산금 정보를 확인할 수 있습니다.</p>
        <a href="/seller/reservation/list">정산 보기</a>
      </div>
    </div>
  </main>

</div> <!-- ✅ admin-container 닫기 -->
</body>
</html>
