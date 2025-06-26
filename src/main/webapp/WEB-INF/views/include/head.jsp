<!-- /WEB-INF/views/include/header.jsp -->
<style>
  :root {
    --bg: #fff; --fg: #000; --gray: #666; --border: #ebebeb; --max: 1440px; --gutter: 48px;
  }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background: var(--bg); color: var(--fg); font-size: 16px; line-height: 1.45;
  }
  a { color: inherit; text-decoration: none; }
  img { display: block; max-width: 100%; }
  .wrap { max-width: var(--max); margin: 0 auto; padding: 0 var(--gutter); }
  .flex { display: flex; }
  .between { justify-content: space-between; }
  .center { align-items: center; }

  header {
    position: sticky; top: 0; z-index: 100; background: var(--bg); border-bottom: 1px solid var(--border);
  }

  .util-bar { height: 64px; }
  .logo {
    display: flex; align-items: center; gap: 10px;
    font-family: 'Montserrat', sans-serif;
    font-size: 28px; font-weight: 700; letter-spacing: 1.5px;
  }

  .util-icons {
    gap: 28px; font-size: 13px; text-transform: uppercase;
  }

  .search {
    width: 26px; height: 26px; border: 2px solid var(--fg); border-radius: 50%;
    position: relative; cursor: pointer;
  }
  .search:after {
    content: ''; position: absolute; width: 12px; height: 2px;
    background: var(--fg); right: -4px; bottom: 4px; transform: rotate(45deg);
  }

  @media(max-width: 760px) {
    .util-bar { height: 56px; }
  }
</style>

<div class="util-bar wrap flex between center">
  <a href="/" class="logo">logo</a>
  <div class="util-icons flex center">
    <a class="icon" href="/mypage">MY PAGE</a>
    <a class="icon" href="/likes">MY LIKE</a>
    <a class="icon" href="/bag">BAG</a>
    <a class="icon" href="/login">LOGIN</a>
    <span class="search" aria-label="Search"></span>
  </div>
</div>
