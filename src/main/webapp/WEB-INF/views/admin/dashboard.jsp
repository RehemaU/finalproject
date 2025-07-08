
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }
        .admin-wrap {
            display: flex;
            height: 100vh;
        }
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
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 12px 20px;
            cursor: pointer;
        }
        .sidebar ul li:hover,
        .sidebar ul li.active {
            background-color: #1ab394;
        }
        .content {
            flex: 1;
            padding: 30px;
            background-color: #f9f9f9;
            overflow-y: auto;
        }
        .content h3 {
            margin-top: 0;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div style="width: 100%; background: #f1f1f1; padding: 10px 20px; text-align: right;">
    <form action="/admin/logout" method="post" style="display: inline;">
        <button type="submit" style="background-color: #d9534f; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer;">
            로그아웃
        </button>
    </form>
</div>



<div class="admin-wrap">
    <!-- 사이드바 -->
    <div class="sidebar">
        <h2>관리자</h2>
        <ul>
            <li class="menu-item active" data-url="/admin/accommList">숙소 관리</li>
            <li class="menu-item" data-url="/admin/userList">유저 관리</li>
            <li class="menu-item" data-url="/admin/reviewList">리뷰 관리</li>
        </ul>
    </div>

    <!-- 메인 컨텐츠 -->
    <div class="content">
        <div id="contentArea">
            <!-- 이 영역에 AJAX로 불러옴 -->
            <h3>숙소 관리</h3>
            <p>여기에 숙소 목록이 AJAX로 표시됩니다.</p>
        </div>
    </div>
</div>

<script>
$(function() {
    // 기본 로딩
    loadContent("/admin/accommList");

    // 메뉴 클릭 시 AJAX 로드
    $('.menu-item').click(function () {
        $('.menu-item').removeClass('active');
        $(this).addClass('active');

        const url = $(this).data('url');
        loadContent(url);
    });

    function loadContent(url) {
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
});
</script>

</body>
</html>
