<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="border:1px solid #ccc; padding:20px; margin-top:20px; border-radius:8px;">
    <h3>공지사항 작성</h3>
    <form id="noticeWriteForm">
        <div style="margin-bottom:10px;">
            <label>제목</label><br/>
            <input type="text" name="noticeTitle" style="width:100%; padding:8px;" required/>
        </div>
        <div style="margin-bottom:10px;">
            <label>내용</label><br/>
            <textarea name="noticeContent" rows="6" style="width:100%; padding:8px;" required></textarea>
        </div>
        <button type="submit" style="padding:8px 16px; background-color:#5cb85c; color:white; border:none; border-radius:4px;">등록</button>
    </form>
</div>

<script>
    // 폼 submit 처리
    $("#noticeWriteForm").on("submit", function (e) {
        e.preventDefault();

        const formData = $(this).serialize();

        $.ajax({
            url: "/admin/noticeWriteProc",
            type: "POST",
            data: formData,
            success: function () {
                alert("공지사항이 등록되었습니다.");
                location.reload(); // 또는 noticeList 다시 호출
            },
            error: function () {
                alert("등록 실패");
            }
        });
    });
</script>
