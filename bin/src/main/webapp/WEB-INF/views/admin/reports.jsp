<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reports — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
  <style>
    .bar-wrap { background:#E5E7EB; border-radius:6px; height:18px; width:100%; margin-top:4px; }
    .bar-fill  { height:18px; border-radius:6px; background:#3b82f6; min-width:4px; }
    .chart-row { display:flex; align-items:center; gap:12px; margin-bottom:10px; }
    .chart-label { min-width:120px; color:#374151; font-size:0.85rem; }
    .chart-count { color:#374151; font-size:0.8rem; min-width:32px; text-align:right; }
    .report-section { padding:0 28px 28px; }
    .report-section h3 { margin-bottom:12px; font-size:0.95rem; color:#111827; }
    .report-table { width:100%; border-collapse:collapse; font-size:0.88rem; }
    .report-table th, .report-table td { padding:10px 12px; border-bottom:1px solid #e5e7eb; text-align:left; color:#374151; }
    .report-table thead { background:#f9fafb; }
  </style>
</head>
<body class="admin-body">

<c:set var="activeNav" value="reports" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main-content">
  <div class="topbar"></div>

  <div class="page-header">
    <h2 class="greeting">Reports</h2>
    <p class="greeting-sub">Booking summary and revenue overview</p>
  </div>

  <c:if test="${not empty reportsError}">
    <div class="msg error" style="margin:20px 28px 0;"><c:out value="${reportsError}"/></div>
  </c:if>

  <!-- KPI cards -->
  <div class="stats-grid">
    <div class="stat-card">
      <div class="stat-icon">&#127903;</div>
      <div class="stat-info">
        <p class="stat-label">Total Bookings</p>
        <h2 class="stat-value"><c:out value="${totalBookings}" default="0"/></h2>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">&#8360;</div>
      <div class="stat-info">
        <p class="stat-label">Confirmed Revenue</p>
        <h2 class="stat-value">Rs. <c:out value="${totalRevenue}" default="0"/></h2>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon">&#127942;</div>
      <div class="stat-info">
        <p class="stat-label">Most Popular Type</p>
        <h2 class="stat-value" style="font-size:1.3rem;">
          <c:out value="${mostPopularType}" default="N/A"/>
        </h2>
      </div>
    </div>
  </div>

  <!-- Two-column row: status table + monthly trend -->
  <div style="display:flex; gap:20px; padding:0 28px 20px; flex-wrap:wrap;">

    <div style="flex:1; min-width:260px;">
      <h3 style="margin-bottom:12px; font-size:0.95rem; color:#111827;">Bookings by Status</h3>
      <c:choose>
        <c:when test="${empty bookingsByStatus}">
          <p style="color:#6b7280; font-size:0.88rem;">No data.</p>
        </c:when>
        <c:otherwise>
          <c:set var="maxBooking" value="1"/>
          <c:forEach var="entry" items="${bookingsByStatus}">
            <c:if test="${entry.value > maxBooking}"><c:set var="maxBooking" value="${entry.value}"/></c:if>
          </c:forEach>
          <c:forEach var="entry" items="${bookingsByStatus}">
            <div class="chart-row">
              <span class="chart-label"><c:out value="${entry.key}"/></span>
              <div class="bar-wrap" style="flex:1">
                <div class="bar-fill" style="width:${entry.value * 100 / maxBooking}%"></div>
              </div>
              <span class="chart-count"><c:out value="${entry.value}"/></span>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <div style="flex:1; min-width:260px;">
      <h3 style="margin-bottom:12px; font-size:0.95rem; color:#111827;">Monthly Booking Trend</h3>
      <div class="table-wrap">
        <table class="table">
          <thead>
            <tr><th>Month</th><th>Bookings</th></tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty bookingsPerMonth}">
                <tr><td colspan="2" class="empty-msg">No data.</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="entry" items="${bookingsPerMonth}">
                  <tr>
                    <td><c:out value="${entry.key}"/></td>
                    <td><c:out value="${entry.value}"/></td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>

  </div>

  <!-- Full-width top events table -->
  <div style="padding:0 28px 28px;">
    <h3 style="margin-bottom:12px; font-size:0.95rem; color:#111827;">Top 5 Most Booked Events</h3>
    <div class="table-wrap">
      <table class="table">
        <thead>
          <tr><th>#</th><th>Event / Venue</th><th>Bookings</th></tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty topEvents}">
              <tr><td colspan="3" class="empty-msg">No data.</td></tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="row" items="${topEvents}" varStatus="s">
                <tr>
                  <td><c:out value="${s.index + 1}"/></td>
                  <td><c:out value="${row[0]}"/></td>
                  <td><c:out value="${row[1]}"/></td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <section class="report-section">
    <h3>Event Availability (Top 5 Most Loaded)</h3>
    <table class="report-table">
      <thead>
        <tr><th>Event Type</th><th>Venue</th><th>Bookings</th><th>Capacity</th><th>Load</th></tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty eventLoadStats}">
            <tr><td colspan="5">No data available.</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="ev" items="${eventLoadStats}">
              <tr>
                <td><c:out value="${ev[0]}"/></td>
                <td><c:out value="${ev[1]}"/></td>
                <td><c:out value="${ev[2]}"/></td>
                <td><c:out value="${ev[3]}"/></td>
                <td>
                  <div class="bar-wrap">
                    <div class="bar-fill" style="width:${ev[4]}%"></div>
                  </div>
                  <small style="color:#374151; margin-top:2px; display:block;"><c:out value="${ev[4]}"/>%</small>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </section>

</main>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
