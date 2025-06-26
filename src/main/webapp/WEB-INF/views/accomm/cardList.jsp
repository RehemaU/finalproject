<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card-grid">
  <c:forEach var="item" items="${results}">
    <div class="card">
      <div class="card-image">
        <c:choose>
          <c:when test="${not empty item.firstImage}">
            <img src="${item.firstImage}" alt="${item.accomName}" />
          </c:when>
          <c:otherwise>
            <div class="no-image">NO IMAGE</div>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="card-title">
        <h3>${item.accomName}</h3>
      </div>
    </div>
  </c:forEach>
</div>

