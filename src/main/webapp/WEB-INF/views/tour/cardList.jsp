<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card-grid">
  <c:forEach var="item" items="${results}">
    <div class="card">
      <div class="card-image">
        <c:choose>
          <c:when test="${not empty item.tourImage}">
            <img src="${item.tourImage}" alt="${item.tourName}" />
          </c:when>
          <c:otherwise>
            <div class="no-image">NO IMAGE</div>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="card-title">
        <h3>${item.tourName}</h3>
      </div>
    </div>
  </c:forEach>
</div>

