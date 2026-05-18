<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<c:set var="activeNav" value="dashboard" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<!-- MAIN CONTENT -->
<main class="main-content">

  <header class="topbar">
    <div class="topbar-right">
      Welcome, <strong><c:out value="${sessionScope.user.fullName}"/></strong>
    </div>
  </header>

  <section class="page-header">
    <h1 class="greeting">Dashboard</h1>
    <p class="greeting-sub">Here's what is happening with your events today.</p>
  </section>

  <c:if test="${not empty dashboardError}">
    <div class="alert alert-error"><c:out value="${dashboardError}"/></div>
  </c:if>

  <!-- KPI CARDS -->
  <section class="stats-grid">
    <div class="stat-card">
      <div class="stat-icon">&#128197;</div>
      <div class="stat-info">
        <p class="stat-label">TOTAL EVENTS</p>
        <h2 class="stat-value"><c:out value="${totalEvents}" default="0"/></h2>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">&#127903;</div>
      <div class="stat-info">
        <p class="stat-label">TOTAL BOOKINGS</p>
        <h2 class="stat-value"><c:out value="${totalBookings}" default="0"/></h2>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">&#128101;</div>
      <div class="stat-info">
        <p class="stat-label">TOTAL USERS</p>
        <h2 class="stat-value"><c:out value="${totalUsers}" default="0"/></h2>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">&#10133;</div>
      <div class="stat-info">
        <p class="stat-label">QUICK ACTIONS</p>
        <a href="${pageContext.request.contextPath}/admin/events?action=add"
           class="btn-create-event">+ Add Event</a>
        <a href="${pageContext.request.contextPath}/admin/venues?action=add"
           class="btn-create-event" style="margin-top:8px;">+ Add Venue</a>
      </div>
    </div>
  </section>

  <!-- UPCOMING EVENTS -->
  <section class="dashboard-grid">
    <div class="upcoming-events">
      <div class="section-header">
        <h3>Upcoming Events</h3>
        <a href="${pageContext.request.contextPath}/admin/events" class="view-all">
          Manage All
        </a>
      </div>

      <c:choose>
        <c:when test="${empty upcomingEvents}">
          <p class="empty-msg">No events found. Add your first event.</p>
        </c:when>
        <c:otherwise>
          <c:forEach var="event" items="${upcomingEvents}">
            <div class="event-card">
              <div class="event-card-info">
                <span class="event-type-badge">
                  <c:out value="${event.eventType}"/>
                </span>
                <p class="event-venue-name">
                  &#128205; <c:out value="${event.venueName}"/>
                </p>
                <p class="event-date">
                  &#128197; <c:out value="${event.eventDate}"/>
                  &nbsp;
                  &#128336; <c:out value="${event.eventTime}"/>
                </p>
                <p class="event-price">
                  &#128178; Rs. <c:out value="${event.eventPrice}"/>
                </p>
                <div class="event-card-actions">
                  <a href="${pageContext.request.contextPath}/admin/events?action=edit&id=${event.eventID}"
                     class="btn-edit-sm">Edit</a>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </section>

</main>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
