<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Segoe UI', sans-serif; }
        .admin-wrap { display: flex; height: 100vh; }
        .sidebar {
            width: 220px;
            background-color: #2f4050;
            color: white;
            padding-top: 20px;
        }
        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 20px;
        }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar ul li {
            padding: 12px 20px;
            cursor: pointer;
        }
        .sidebar ul li:hover, .sidebar ul li.active {
            background-color: #1ab394;
        }
        .content {
            flex: 1;
            padding: 30px;
            background-color: #f9f9f9;
            overflow-y: auto;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- 상단 로그아웃 -->
<div style="width: 100%; background: #f1f1f1; padding: 10px 20px; text-align: right;">
    <form action="/admin/logout" method="post" style="display: inline;">
        <button type="submit" style="background-color: #d9534f; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer;">로그아웃</button>
    </form>
</div>

<!-- 좌측 메뉴 / 우측 내용 -->
<div class="admin-wrap">
    <div class="sidebar">
        <h2>관리자</h2>
        <ul>
            <li class="menu-item active" data-url="/admin/accommList">숙소 관리</li>
            <li class="menu-item" data-url="/admin/userList">유저 관리</li>
            <li class="menu-item" data-url="/admin/reviewList">리뷰 관리</li>
            <li class="menu-item" data-url="/admin/sellerList">판매자 관리</li>
        </ul>
    </div>

    <div class="content">
        <div id="contentArea">불러오는 중입니다...</div>
    </div>
</div>

<script>
let accommParams = { keyword: '', status: '', page: 1 };

// ✅ 공통 AJAX 로딩 함수
function loadContent(url) {
    $("#contentArea").html("<p style='text-align:center; margin-top: 50px;'>불러오는 중입니다...</p>");
    $.ajax({
        url: url,
        type: "GET",
        success: function (data) {
            $("#contentArea").html(data);
        },
        error: function () {
            $("#contentArea").html("<p>불러오기 실패</p>");
        }
    });
}

// ✅ 숙소 리스트 파라미터 보존 로딩 함수
function loadAccommList() {
    const { keyword, status, page } = accommParams;
    const url = "/admin/accommList?keyword=" + encodeURIComponent(keyword)
                + "&status=" + status
                + "&page=" + page;
    loadContent(url);
}

// ✅ 유저 관련 초기 이벤트 바인딩
function initUserEvents() {
    // 유저 검색
    $(document).on('click', '#userSearchBtn', function () {
        const keyword = $('#userSearchInput').val();
        $.ajax({
            url: '/admin/userList',
            type: 'GET',
            data: { keyword },
            success: function (data) {
                $('#contentArea').html(data);
            }
        });
    });

    // 유저 페이징
    $(document).on('click', '.user-page-link', function () {
        const page = $(this).data('page');
        const keyword = $('#userSearchInput').val();
        $.ajax({
            url: '/admin/userList',
            type: 'GET',
            data: { page, keyword },
            success: function (data) {
                $('#contentArea').html(data);
            }
        });
    });

    // 유저 상태 변경
    $(document).on("click", ".toggle-user-btn", function () {
        const userId = $(this).data("userid");
        const status = $(this).data("status");
        $.ajax({
            type: 'POST',
            url: '/admin/toggleUserStatus',
            data: { userId, status },
            success: function (res) {
                if (res.code === 0) {
                    const keyword = $('#userSearchInput').val();
                    const curPage = 1;
                    $.ajax({
                        url: '/admin/userList',
                        type: 'GET',
                        data: { page: curPage, keyword },
                        success: function (data) {
                            $('#contentArea').html(data);
                        }
                    });
                } else {
                    alert("처리에 실패했습니다.");
                }
            },
            error: function () {
                alert("서버 오류 발생");
            }
        });
    });
}

// ✅ 숙소 관련 초기 이벤트 바인딩
function initAccommEvents() {
    // 숙소 검색
    $(document).on("click", "#accommSearchBtn_acc", function () {
        const keyword = $("#accommSearchInput_acc").val().trim();
        accommParams.keyword = keyword;
        accommParams.page = 1;
        loadAccommList();
    });

    // 숙소 상태 필터
    $(document).on("click", "#filterPendingBtn, #filterAllBtn", function () {
        const status = $(this).data("status") || '';
        $(".filter-btn").removeClass("active");
        $(this).addClass("active");
        accommParams.status = status;
        accommParams.page = 1;
        loadAccommList();
    });

    // 숙소 페이징
    $(document).on("click", ".accomm-page-link", function () {
        const page = $(this).data("page");
        accommParams.page = page;
        loadAccommList();
    });

    // 숙소 승인
    $(document).on("click", ".approve-btn", function () {
        const accommId = $(this).data("accomm-id");
        if (!confirm("이 숙소를 승인하시겠습니까?")) return;

        $.ajax({
            type: 'POST',
            url: '/admin/approveAccomm',
            data: { accommId },
            success: function (res) {
                if (res.code === 0) {
                    alert("승인 완료");
                    loadAccommList();
                } else {
                    alert("승인 실패");
                }
            }
        });
    });
}

// ✅ 전체 초기화
function initDashboard() {
    loadAccommList();          // 초기 로딩은 숙소
    initUserEvents();          // 유저 이벤트 등록
    initAccommEvents();        // 숙소 이벤트 등록

    // 메뉴 클릭 시 화면 전환
    $(document).on("click", ".menu-item", function () {
        $(".menu-item").removeClass("active");
        $(this).addClass("active");
        const url = $(this).data("url");
        loadContent(url);
    });
}

$(document).ready(function () {
    initDashboard();
});
</script>

</body>
</html>
