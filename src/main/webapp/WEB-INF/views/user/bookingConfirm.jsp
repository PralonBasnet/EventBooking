<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Booking Confirmed — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookingConfirm.css">
</head>
<body class="dark-page">

<c:set var="activeNav" value="" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<div class="confirm-wrap">
  <div class="confirm-card">
    <div class="confirm-icon">&#10003;</div>
    <h2>Booking Confirmed!</h2>
    <p class="confirm-sub">
      Thank you, <strong><c:out value="${sessionScope.user.fullName}"/></strong>.
      Your reservation has been received.
    </p>

    <div class="confirm-details">
      <div class="detail-row">
        <span class="detail-label">Booking ID</span>
        <span class="detail-value">#<c:out value="${bookingID}"/></span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Event Type</span>
        <span class="detail-value"><c:out value="${event.eventType}"/></span>
      </div>
      <c:if test="${not empty event.venueName}">
        <div class="detail-row">
          <span class="detail-label">Venue</span>
          <span class="detail-value"><c:out value="${event.venueName}"/></span>
        </div>
      </c:if>
      <div class="detail-row">
        <span class="detail-label">Date</span>
        <span class="detail-value"><c:out value="${event.eventDate}"/></span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Time</span>
        <span class="detail-value"><c:out value="${event.eventTime}"/></span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Total Due</span>
        <span class="detail-value amount">Rs. <c:out value="${event.eventPrice}"/></span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Booking Status</span>
        <span class="detail-value status-pending"><c:out value="${bookingStatus}"/></span>
      </div>
      <div class="detail-row">
        <span class="detail-label">Payment Status</span>
        <span class="detail-value status-pending"><c:out value="${paymentStatus}"/></span>
      </div>
    </div>

    <p class="confirm-pending-note">
      &#128276; Your application is pending admin review. You will be notified once it is confirmed.
    </p>

    <div class="confirm-actions">
      <a href="${pageContext.request.contextPath}/MyBookings" class="btn-primary">
        View My Bookings
      </a>
      <a href="${pageContext.request.contextPath}/Events" class="btn-secondary">
        Browse More Events
      </a>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
