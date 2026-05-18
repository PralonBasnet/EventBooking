<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Bookings — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myBookings.css">
</head>
<body class="dark-page">

<c:set var="activeNav" value="" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<div class="page-wrap">
  <div class="page-header">
    <h1>My Bookings</h1>
    <p>Your reservation history</p>
  </div>

  <c:if test="${not empty bookingsError}">
    <div class="alert-error"><c:out value="${bookingsError}"/></div>
  </c:if>

  <div class="table-wrap">
    <table class="bookings-table">
      <thead>
        <tr>
          <th>#</th>
          <th>Booking ID</th>
          <th>Event</th>
          <th>Venue</th>
          <th>Date</th>
          <th>Time</th>
          <th>Total (Rs.)</th>
          <th>Status</th>
          <th>Payment</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty bookings}">
            <tr>
              <td colspan="9" class="empty-msg">
                You have no bookings yet.
                <a href="${pageContext.request.contextPath}/Events">Browse events</a>
              </td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="b" items="${bookings}" varStatus="s">
              <tr>
                <td><c:out value="${s.index + 1}"/></td>
                <td>#<c:out value="${b.bookingID}"/></td>
                <td><c:out value="${b.eventType}"/></td>
                <td><c:out value="${b.venueName}"/></td>
                <td><c:out value="${b.eventDate}"/></td>
                <td><c:out value="${b.eventTime}"/></td>
                <td><c:out value="${b.totalAmount}"/></td>
                <td>
                  <span class="status-badge status-${b.bookingStatus}">
                    <c:out value="${b.bookingStatus}"/>
                  </span>
                </td>
                <td>
                  <span class="payment-badge payment-${b.paymentStatus}">
                    <c:out value="${b.paymentStatus}"/>
                  </span>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>

  <div class="back-link-wrap">
    <a href="${pageContext.request.contextPath}/Home" class="btn-back">
      &larr; Browse More Events
    </a>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
