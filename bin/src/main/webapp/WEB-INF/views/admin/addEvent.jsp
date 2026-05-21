<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Event — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addEvent.css">
</head>
<body class="admin-body">

<c:set var="activeNav" value="events" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main-content">

  <header class="topbar">
    <a href="${pageContext.request.contextPath}/admin/events" class="back-link">
      &#8592; Back to Events
    </a>
  </header>

  <section class="page-header">
    <h1 class="page-title">Add New Event</h1>
    <p class="page-sub">Fill in the details to create a new event.</p>
  </section>

  <c:if test="${not empty error}">
    <div class="alert alert-error">
      &#9888; <c:out value="${error}"/>
    </div>
  </c:if>

  <div class="form-container">
    <form action="${pageContext.request.contextPath}/admin/events"
          method="post" class="admin-form">

      <input type="hidden" name="action" value="add">

      <div class="form-grid">

        <div class="form-group">
          <label for="eventType">Event Type <span class="required">*</span></label>
          <select id="eventType" name="eventType" class="form-control" required>
            <option value="">-- Select Type --</option>
            <option value="Conference">Conference</option>
            <option value="Fundraiser">Fundraiser</option>
            <option value="Gala">Gala</option>
            <option value="Wedding">Wedding</option>
            <option value="Corporate">Corporate</option>
            <option value="Concert">Concert</option>
            <option value="Workshop">Workshop</option>
            <option value="Other">Other</option>
          </select>
        </div>

        <div class="form-group">
          <label for="venueID">Venue <span class="required">*</span></label>
          <select id="venueID" name="venueID" class="form-control" required>
            <option value="">-- Select Venue --</option>
            <c:forEach var="venue" items="${venues}">
              <option value="${venue.venueID}">
                <c:out value="${venue.venueName}"/>
              </option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="eventDate">Event Date <span class="required">*</span></label>
          <input type="date" id="eventDate" name="eventDate"
                 class="form-control" required>
        </div>

        <div class="form-group">
          <label for="eventTime">Event Time <span class="required">*</span></label>
          <input type="time" id="eventTime" name="eventTime"
                 class="form-control" required>
        </div>

        <div class="form-group">
          <label for="eventPrice">Price (Rs.) <span class="required">*</span></label>
          <input type="number" id="eventPrice" name="eventPrice"
                 class="form-control"
                 placeholder="e.g. 250.00"
                 min="0" step="0.01" required>
        </div>

      </div>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/admin/events" class="btn-secondary">Cancel</a>
        <button type="submit" class="btn-primary">
          + Create Event
        </button>
      </div>

    </form>
  </div>
</main>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
