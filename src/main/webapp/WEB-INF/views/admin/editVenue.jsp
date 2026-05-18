<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Venue — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editEvent.css?v=2">
</head>
<body class="admin-body">

<c:set var="activeNav" value="venues" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main-content">

  <header class="topbar">
    <a href="${pageContext.request.contextPath}/admin/venues" class="back-link">
      &#8592; Back to Venues
    </a>
  </header>

  <section class="page-header">
    <h1 class="page-title">Edit Venue</h1>
    <p class="page-sub">Editing: <strong><c:out value="${venue.venueName}"/></strong></p>
  </section>

  <c:if test="${not empty error}">
    <div class="alert alert-error">
      &#9888; <c:out value="${error}"/>
    </div>
  </c:if>

  <div class="form-container">
    <form action="${pageContext.request.contextPath}/admin/venues"
          method="post" class="admin-form">

      <input type="hidden" name="action"  value="update">
      <input type="hidden" name="venueID" value="${venue.venueID}">

      <div class="form-grid">

        <div class="form-group full-width">
          <label for="venueName">Venue Name <span class="required">*</span></label>
          <input type="text" id="venueName" name="venueName"
                 class="form-control"
                 value="<c:out value='${venue.venueName}'/>" required>
        </div>

        <div class="form-group">
          <label for="venueCapacity">Capacity <span class="required">*</span></label>
          <input type="number" id="venueCapacity" name="venueCapacity"
                 class="form-control"
                 value="${venue.venueCapacity}" min="1" required>
        </div>

        <div class="form-group">
          <label for="venueContact">Contact Number <span class="required">*</span></label>
          <input type="text" id="venueContact" name="venueContact"
                 class="form-control"
                 value="<c:out value='${venue.venueContact}'/>" required>
        </div>

        <div class="form-group full-width">
          <label for="venueAddress">Address <span class="required">*</span></label>
          <input type="text" id="venueAddress" name="venueAddress"
                 class="form-control"
                 value="<c:out value='${venue.venueAddress}'/>" required>
        </div>

      </div>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/admin/venues" class="btn-secondary">Cancel</a>
        <button type="submit" class="btn-primary">
          &#128190; Save Changes
        </button>
      </div>

    </form>
  </div>
</main>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
