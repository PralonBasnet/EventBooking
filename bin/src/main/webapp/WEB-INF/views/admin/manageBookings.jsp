<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Bookings — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<c:set var="activeNav" value="bookings" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main-content">
  <div class="topbar"></div>

  <div class="page-header">
    <h2 class="greeting">Manage Bookings</h2>
    <p class="greeting-sub">Confirm, mark paid, or cancel bookings</p>
  </div>

  <c:if test="${param.success eq 'confirm'}">
    <div class="msg success">Booking confirmed.</div>
  </c:if>
  <c:if test="${param.success eq 'markPaid'}">
    <div class="msg success">Booking marked as paid.</div>
  </c:if>
  <c:if test="${param.success eq 'cancel'}">
    <div class="msg success">Booking cancelled.</div>
  </c:if>
  <c:if test="${param.error eq 'update_failed'}">
    <div class="msg error">Update failed. Please try again.</div>
  </c:if>
  <c:if test="${not empty bookingsError}">
    <div class="msg error"><c:out value="${bookingsError}"/></div>
  </c:if>

  <div style="padding:0 28px 8px;">
    <p style="font-size:0.85rem; color:#6B7280;">
      Showing <strong><c:out value="${bookingCount}" default="0"/></strong> booking(s)
    </p>
  </div>

  <div style="padding:0 28px 28px;">
    <div class="table-wrap">
      <table class="table">
        <thead>
          <tr>
            <th>#</th>
            <th>Booking ID</th>
            <th>Customer</th>
            <th>Event</th>
            <th>Venue</th>
            <th>Event Date</th>
            <th>Booked On</th>
            <th>Amount (Rs.)</th>
            <th>Status</th>
            <th>Payment</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty bookings}">
              <tr>
                <td colspan="11" class="empty-msg">No bookings found.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="b" items="${bookings}" varStatus="s">
                <tr>
                  <td><c:out value="${s.index + 1}"/></td>
                  <td>#<c:out value="${b.bookingID}"/></td>
                  <td><c:out value="${b.customerName}"/></td>
                  <td><c:out value="${b.eventType}"/></td>
                  <td><c:out value="${b.venueName}"/></td>
                  <td><c:out value="${b.eventDate}"/></td>
                  <td><c:out value="${b.bookingDate}"/></td>
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
                  <td>
                    <c:if test="${b.bookingStatus eq 'PENDING'}">
                      <form action="${pageContext.request.contextPath}/admin/bookings" method="post" style="display:inline">
                        <input type="hidden" name="action"    value="confirm">
                        <input type="hidden" name="bookingID" value="${b.bookingID}">
                        <button type="submit" class="btn-edit-sm">&#10003; Confirm</button>
                      </form>
                      <form action="${pageContext.request.contextPath}/admin/bookings" method="post" style="display:inline">
                        <input type="hidden" name="action"    value="cancel">
                        <input type="hidden" name="bookingID" value="${b.bookingID}">
                        <button type="submit" class="btn-edit-sm"
                                style="background:#FEE2E2; color:#991B1B;"
                                onclick="return confirm('Cancel this booking?')">&#10007; Cancel</button>
                      </form>
                    </c:if>
                    <c:if test="${b.bookingStatus eq 'CONFIRMED' and b.paymentStatus eq 'UNPAID'}">
                      <form action="${pageContext.request.contextPath}/admin/bookings" method="post" style="display:inline">
                        <input type="hidden" name="action"    value="markPaid">
                        <input type="hidden" name="bookingID" value="${b.bookingID}">
                        <button type="submit" class="btn-edit-sm">Rs. Mark Paid</button>
                      </form>
                    </c:if>
                    <c:if test="${b.bookingStatus eq 'CONFIRMED' and b.paymentStatus eq 'PAID'}">
                      <form action="${pageContext.request.contextPath}/admin/bookings" method="post" style="display:inline">
                        <input type="hidden" name="action"    value="cancelRefund">
                        <input type="hidden" name="bookingID" value="${b.bookingID}">
                        <button type="submit" class="btn-suspend"
                                onclick="return confirm('Cancel and refund this booking?')">Cancel &amp; Refund</button>
                      </form>
                    </c:if>
                    <c:if test="${b.bookingStatus ne 'PENDING' and not (b.bookingStatus eq 'CONFIRMED' and b.paymentStatus eq 'UNPAID') and not (b.bookingStatus eq 'CONFIRMED' and b.paymentStatus eq 'PAID')}">
                      <span style="color:#9CA3AF; font-size:0.85rem;">—</span>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>
</main>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
