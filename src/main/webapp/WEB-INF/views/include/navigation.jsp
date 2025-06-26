<!-- /WEB-INF/views/include/nav.jsp -->
<style>
  .tagline {
    padding: 38px 0 22px;
    display: flex; gap: 26px; flex-wrap: wrap;
  }

  .tag-item {
    position: relative; font-weight: 700; font-size: 42px;
    white-space: nowrap; cursor: pointer;
  }

  .tag-item::after {
    content: ''; position: absolute; left: 0; bottom: -6px;
    width: 100%; height: 3px; background: var(--fg);
    transform: scaleX(0); transform-origin: left; transition: .3s;
  }

  .tag-item:hover::after { transform: scaleX(1); }

  .gnb {
    padding: 14px 0 18px; gap: 36px;
    font-weight: 500; font-size: 15px;
    white-space: nowrap; overflow-x: auto;
    border-bottom: 1px solid var(--border);
  }

  .gnb a { opacity: .75; flex-shrink: 0; }
  .gnb a:hover { opacity: 1; }

  @media(max-width: 1100px) {
    .tag-item { font-size: 34px; }
  }

  @media(max-width: 760px) {
    .tag-item { font-size: 26px; }
    .gnb { gap: 20px; font-size: 14px; }
  }
</style>

<div class="tagline wrap">
  <a class="tag-item" href="/walkthrough">Walkthrough</a>
  <a class="tag-item" href="/tour">Explore</a>
  <a class="tag-item" href="/stay">Stay</a>
  <a class="tag-item" href="/schedule">Plan</a>
  <a class="tag-item" href="/review">Share</a>
</div>

<nav class="gnb wrap flex center">
  <a href="/tour">TOUR</a>
  <a href="/stay">STAY</a>
  <a href="/schedule">SCHEDULE</a>
  <a href="/review">REVIEW</a>
  <a href="/coupon">COUPON</a>
  <a href="/event">EVENT</a>
  <a href="/qna">Q&A</a>
</nav>
