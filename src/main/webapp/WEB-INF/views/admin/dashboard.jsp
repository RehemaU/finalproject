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
            <li class="menu-item" data-url="/admin/noticeList">공지사항 관리</li>
            <li class="menu-item" data-url="/admin/eventList">이벤트 관리<li>
        </ul>
    </div>

    <div class="content">
        <div id="contentArea">불러오는 중입니다...</div>
    </div>
</div>

<script>
let accommParams = { keyword: '', status: '', page: 1 };

//  공통 AJAX 로딩 함수
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

//  숙소 리스트 파라미터 보존 로딩 함수
function loadAccommList() {
    const { keyword, status, page } = accommParams;
    const url = "/admin/accommList?keyword=" + encodeURIComponent(keyword)
                + "&status=" + status
                + "&page=" + page;
    loadContent(url);
}

//  유저 관련 초기 이벤트 바인딩
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

//  숙소 관련 초기 이벤트 바인딩
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
function initReviewEvents() {
    // 검색 버튼 클릭 시
    $(document).on("click", "#reviewSearchBtn_rev", function () {
        const keyword = $("#reviewSearchInput_rev").val();
        const order = $("#reviewOrderSelect_rev").val();
        $.ajax({
            url: "/admin/reviewList",
            type: "GET",
            data: { keyword, order },
            success: function (data) {
                $("#contentArea").html(data);
            }
        });
    });

    // 페이지 링크 클릭 시
    $(document).on("click", ".review-page-link", function () {
        const page = $(this).data("page");
        const keyword = $("#reviewSearchInput_rev").val();
        const order = $("#reviewOrderSelect_rev").val();
        $.ajax({
            url: "/admin/reviewList",
            type: "GET",
            data: { page, keyword, order },
            success: function (data) {
                $("#contentArea").html(data);
            }
        });
    });

    // 정렬 순서 변경 시
    $(document).on("change", "#reviewOrderSelect_rev", function () {
        $("#reviewSearchBtn_rev").click();  // 자동으로 검색 재실행
    });
    
 // 상태 필터 버튼 클릭 (공개/비공개)
    $(document).on("click", "#filterPublicReviewBtn, #filterPrivateReviewBtn", function () {
        const status = $(this).data("status");
        $(".filter-btn").removeClass("active");
        $(this).addClass("active");

        const keyword = $("#reviewSearchInput_rev").val();
        const order = $("#reviewOrderSelect_rev").val();

        $.ajax({
            url: "/admin/reviewList",
            type: "GET",
            data: { keyword, order, status },
            success: function (data) {
                $("#contentArea").html(data);
            }
        });
    });
    
}


//  전체 초기화
function initDashboard() {
    loadAccommList();          // 초기 로딩은 숙소
    initUserEvents();          // 유저 이벤트 등록
    initAccommEvents();        // 숙소 이벤트 등록
    initReviewEvents();

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


//리뷰 비공개 처리 버튼 이벤트 위임 (고친 버전)
$(document).on("click", ".review-hide-btn", function () {
    const planId = $(this).data("plan-id");

    if (confirm("해당 리뷰를 비공개 처리하시겠습니까?")) {
        fetch("/admin/updateReviewStatus", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ planId: planId, status: "N" })
        })
        .then(res => res.json())
        .then(data => {
            if (data.code === 0) {
                alert("비공개 처리 완료");

                //  현재 검색어, 정렬, 상태, 페이지 유지
                const keyword = $("#reviewSearchInput_rev").val();
                const order = $("#reviewOrderSelect_rev").val();
                const status = $(".filter-btn.active").data("status") || "Y";
                const curPage = $(".review-page-link.active").data("page") || 1;

                const query = "?page=" + curPage +
                "&keyword=" + encodeURIComponent(keyword) +
                "&order=" + order +
                "&status=" + status;
                loadContent("/admin/reviewList" + query); // ✅ reload 말고 이걸로 대체!
            } else {
                alert("처리 실패: " + data.msg);
            }
        })
        .catch(err => {
            console.error("에러 발생", err);
            alert("서버 오류");
        });
    }
});


$(document).on("click", ".review-title-link", function () {
    const planId = $(this).data("plan-id");
    const calendarId = $(this).data("calendar-id");

    console.log("planId:", planId);
    console.log("calendarId:", calendarId);

    if (!planId || !calendarId) {
        alert("리뷰 상세 정보가 부족합니다.");
        return;
    }

    const url = "/editor/planview?planId=" + encodeURIComponent(planId) +
                "&tCalanderListId=" + encodeURIComponent(calendarId);
    window.open(url, "_blank");
});

function initNoticeEvents() {
    let noticeParams = { keyword: '', page: 1 };


    function renderNoticeTable(noticeList, totalCount, curPage, totalPage) {
        let html = "";
        if (noticeList.length === 0) {
            html = "<tr><td colspan='5'>등록된 공지사항이 없습니다.</td></tr>";
        } else {
            for (let i = 0; i < noticeList.length; i++) {
                const notice = noticeList[i];
                const index = totalCount - ((curPage - 1) * 10) - i;
                html += `
                    <tr>
                        <td>${index}</td>
                        <td class="title-cell">
                            <a href="/notice/noticeDetail?noticeId=${notice.noticeId}">
                                ${notice.noticeTitle}
                            </a>
                        </td>
                        <td>${notice.noticeCount}</td>
                        <td>${notice.noticeRegdate ? notice.noticeRegdate.substring(0, 10) : ''}</td>
                        <td>
                            <button class="action-btn edit-btn" data-id="${notice.noticeId}">수정</button>
                            <button class="action-btn delete-btn" data-id="${notice.noticeId}">삭제</button>
                        </td>
                    </tr>
                `;
            }
        }
        $("#noticeTableBody").html(html);
        renderNoticePagination(curPage, totalPage);
    }

    function renderNoticePagination(curPage, totalPage) {
        let html = "";
        if (curPage > 1) html += `<a href="#" data-page="${curPage - 1}">이전</a>`;
        
        for (let i = 1; i <= totalPage; i++) {
            const isActive = (i == curPage) ? 'active' : '';
            html += `<a href="#" class="\${isActive}" data-page="\${i}">\${i}</a>`
                .replace(/\$\{isActive\}/g, isActive)
                .replace(/\$\{i\}/g, i);
        }

        if (curPage < totalPage) html += `<a href="#" data-page="${curPage + 1}">다음</a>`;
        $("#noticePagination").html(html);
    }

    // 이벤트 바인딩
    $(document).off("click", "#noticeSearchBtn").on("click", "#noticeSearchBtn", function () {
        noticeParams.keyword = $("#noticeSearchInput").val().trim();
        noticeParams.page = 1;
        loadNoticeList();
    });

    $(document).off("click", "#noticePagination a").on("click", "#noticePagination a", function (e) {
        e.preventDefault();
        noticeParams.page = $(this).data("page");
        loadNoticeList();
    });

    $(document).off("click", "#noticeWriteBtn").on("click", "#noticeWriteBtn", function (e) {
        e.preventDefault(); // ✅ 페이지 이동 방지
        $.ajax({
            url: "/admin/noticeWriteForm",
            type: "GET",
            success: function (res) {
                $("#contentArea").html(res); // ✅ 대시보드 우측 영역에 폼 삽입
            },
            error: function () {
                alert("작성 폼 로딩 실패");
            }
        });
    });
    
    $(document).off("click", ".edit-btn").on("click", ".edit-btn", function () {
        const noticeId = $(this).data("id");
        console.log("수정 클릭 - noticeId:", noticeId);

        $.ajax({
            url: "/admin/noticeUpdateForm",
            type: "GET",
            data: { noticeId: noticeId },
            success: function (html) {
                $("#contentArea").html(html);
            },
            error: function () {
                alert("수정 폼 로딩 실패");
            }
        });
    });

    $(document).on("click", ".delete-btn", function () {
        const noticeId = $(this).data("id");
        deleteNotice(noticeId);
    });

    function deleteNotice(noticeId) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: "/admin/noticeDelete",
                type: "POST",
                data: { noticeId: noticeId },  // ✅ 이게 필수
                success: function (res) {
                    if (res.code === 0) {
                        alert("삭제 완료");
                        loadNoticeList();  // 다시 리스트 불러오기
                    } else {
                        alert("삭제 실패: " + res.msg);
                    }
                },
                error: function () {
                    alert("서버 오류");
                }
            });
        }
    }
    loadNoticeList();  // ✅ 초기에 불러오기
    
    
    
}
//대시보드에서 이벤트 목록 로드
$(document).on("click", "#eventManageBtn", function () {
    $.ajax({
        url: "/admin/eventList",
        type: "GET",
        success: function (html) {
            $("#adminContentArea").html(html);
        }
    });
});
//이벤트 탭 페이징 버튼 클릭 처리
$(document).on("click", ".event-page-link", function () {
    const page = $(this).data("page");
    const keyword = $("#adminEventSearchInput").val().trim();

    $("#contentArea").load("/admin/eventList?page=" + page + "&keyword=" + encodeURIComponent(keyword));
});

$(document).on("click", "#openEventWriteBtn", function () {
	  $("#contentArea").load("/admin/eventWriteForm");
	});
</script>

</body>
</html>
