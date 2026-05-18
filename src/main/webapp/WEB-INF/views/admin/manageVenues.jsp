<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Venues — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageEvents.css">
</head>
<body class="admin-body">

<c:set var="activeNav" value="venues" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main">
  <section class="header">
    <div>
      <h1 class="title">Manage Venues</h1>
      <p class="subtitle">Add, edit, or remove event venues</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/venues?action=add" class="btn">
      + Add Venue
    </a>
  </section>

  <c:if test="${param.success eq 'added'}">
    <div class="msg success">Venue added successfully.</div>
  </c:if>
  <c:if test="${param.success eq 'updated'}">
    <div class="msg success">Venue updated successfully.</div>
  </c:if>
  <c:if test="${param.success eq 'deleted'}">
    <div class="msg success">Venue deleted.</div>
  </c:if>
  <c:if test="${not empty param.error}">
    <div class="msg error"><c:out value="${param.error}"/></div>
  </c:if>

  <div class="table-wrap">
    <table class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>Venue Name</th>
          <th>Capacity</th>
          <th>Contact</th>
          <th>Address</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty venues}">
            <tr>
              <td colspan="6" class="empty-msg">No venues found. Add your first venue.</td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="venue" items="${venues}" varStatus="s">
              <tr>
                <td><c:out value="${s.index + 1}"/></td>
                <td><c:out value="${venue.venueName}"/></td>
                <td><c:out value="${venue.venueCapacity}"/></td>
                <td><c:out value="${venue.venueContact}"/></td>
                <td><c:out value="${venue.venueAddress}"/></td>
                <td class="actions">
                  <a class="btn-edit"
                     href="${pageContext.request.contextPath}/admin/venues?action=edit&id=${venue.venueID}">
                    &#9999; Edit
                  </a>
                  <form action="${pageContext.request.contextPath}/admin/venues" method="post"
                        style="display:inline"
                        onsubmit="return confirmDelete('Delete this venue? It will be hidden but kept for audit.')">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id"     value="${venue.venueID}">
                    <button type="submit" class="btn-delete">&#128465; Delete</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</main>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
