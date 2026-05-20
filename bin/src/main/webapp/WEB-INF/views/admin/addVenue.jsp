<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Venue — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addEvent.css">
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
    <h1 class="page-title">Add New Venue</h1>
    <p class="page-sub">Register a new event location.</p>
  </section>

  <c:if test="${not empty error}">
    <div class="alert alert-error">
      &#9888; <c:out value="${error}"/>
    </div>
  </c:if>

  <div class="form-container">
    <form action="${pageContext.request.contextPath}/admin/venues"
          method="post" class="admin-form">

      <input type="hidden" name="action" value="add">

      <div class="form-grid">

        <div class="form-group full-width">
          <label for="venueName">Venue Name <span class="required">*</span></label>
          <input type="text" id="venueName" name="venueName"
                 class="form-control" placeholder="e.g. Grand Ballroom" required>
        </div>

        <div class="form-group">
          <label for="venueCapacity">Capacity <span class="required">*</span></label>
          <input type="number" id="venueCapacity" name="venueCapacity"
                 class="form-control" placeholder="e.g. 500" min="1" required>
        </div>

        <div class="form-group">
          <label for="venueContact">Contact Number <span class="required">*</span></label>
          <input type="text" id="venueContact" name="venueContact"
                 class="form-control" placeholder="e.g. 01-4441001" required>
        </div>

        <div class="form-group full-width">
          <label for="venueAddress">Address <span class="required">*</span></label>
          <input type="text" id="venueAddress" name="venueAddress"
                 class="form-control" placeholder="e.g. 123 Heritage Road, Kathmandu" required>
        </div>

      </div>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/admin/venues" class="btn-secondary">Cancel</a>
        <button type="submit" class="btn-primary">
          + Add Venue
        </button>
      </div>

    </form>
  </div>
</main>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
