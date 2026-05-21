<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %> 
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Event — BookYourEvents</title>

  <!-- Page CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editEvent.css?v=2">
</head>
<body class="admin-body">

<c:set var="activeNav" value="events" scope="request"/>

<!-- Admin navbar -->
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main-content">

  <header class="topbar">

    <!-- Back navigation -->
    <a href="${pageContext.request.contextPath}/admin/events" class="back-link">
      &#8592; Back to Events
    </a>

  </header>

  <section class="page-header">
    <h1 class="page-title">Edit Event</h1>

    <!-- Showing current event ID -->
    <p class="page-sub">
      Event ID: <strong><c:out value="${event.eventID}"/></strong>
    </p>
  </section>

  <!-- Error message -->
  <c:if test="${not empty error}">
    <div class="alert alert-error">
      &#9888; <c:out value="${error}"/>
    </div>
  </c:if>

  <div class="form-container">

    <!-- Update event form -->
    <form action="${pageContext.request.contextPath}/admin/events"
          method="post" class="admin-form">

      <input type="hidden" name="action"  value="update">
      <input type="hidden" name="eventID" value="${event.eventID}">

      <div class="form-grid">

        <!--
          Event type dropdown.
          Options written manually because inline EL arrays
          were causing issues in Tomcat.
        -->
        <div class="form-group">
          <label for="eventType">Event Type <span class="required">*</span></label>

          <select id="eventType" name="eventType" class="form-control" required>

            <option value="Conference"
              <c:if test="${event.eventType eq 'Conference'}">selected</c:if>>
              Conference
            </option>

            <option value="Fundraiser"
              <c:if test="${event.eventType eq 'Fundraiser'}">selected</c:if>>
              Fundraiser
            </option>

            <option value="Gala"
              <c:if test="${event.eventType eq 'Gala'}">selected</c:if>>
              Gala
            </option>

            <option value="Wedding"
              <c:if test="${event.eventType eq 'Wedding'}">selected</c:if>>
              Wedding
            </option>

            <option value="Corporate"
              <c:if test="${event.eventType eq 'Corporate'}">selected</c:if>>
              Corporate
            </option>

            <option value="Concert"
              <c:if test="${event.eventType eq 'Concert'}">selected</c:if>>
              Concert
            </option>

            <option value="Workshop"
              <c:if test="${event.eventType eq 'Workshop'}">selected</c:if>>
              Workshop
            </option>

            <option value="Other"
              <c:if test="${event.eventType eq 'Other'}">selected</c:if>>
              Other
            </option>

          </select>
        </div>

        <!-- Venue dropdown -->
        <div class="form-group">
          <label for="venueID">Venue <span class="required">*</span></label>

          <select id="venueID" name="venueID" class="form-control" required>

            <option value="">-- Select Venue --</option>

            <!-- Loop through venues -->
            <c:forEach var="venue" items="${venues}">
              <option value="${venue.venueID}"
                <c:if test="${venue.venueID eq event.venueID}">selected</c:if>>

                <c:out value="${venue.venueName}"/>

              </option>
            </c:forEach>

          </select>
        </div>

        <!-- Event date -->
        <div class="form-group">
          <label for="eventDate">Event Date <span class="required">*</span></label>

          <input type="date" id="eventDate" name="eventDate"
                 class="form-control"
                 value="${event.eventDate}" required>
        </div>

        <!-- Event time -->
        <div class="form-group">
          <label for="eventTime">Event Time <span class="required">*</span></label>

          <input type="time" id="eventTime" name="eventTime"
                 class="form-control"
                 value="${event.eventTime}" required>
        </div>

        <!-- Event price -->
        <div class="form-group">
          <label for="eventPrice">Price (Rs.) <span class="required">*</span></label>

          <input type="number" id="eventPrice" name="eventPrice"
                 class="form-control"
                 value="${event.eventPrice}"
                 min="0" step="0.01" required>
        </div>

      </div>

      <!-- Form buttons -->
      <div class="form-actions">

        <a href="${pageContext.request.contextPath}/admin/events"
           class="btn-secondary">
          Cancel
        </a>

        <button type="submit" class="btn-primary">
          &#128190; Save Changes
        </button>

      </div>

    </form>
  </div>
</main>

<!-- External JS -->
<script src="${pageContext.request.contextPath}/js/app.js"></script>

</body>
</html>