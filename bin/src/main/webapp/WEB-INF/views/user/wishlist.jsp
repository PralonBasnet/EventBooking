<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Wishlist — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body class="dark-page">

<c:set var="activeNav" value="" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<section class="events-section">
  <div class="events-inner">
    <span class="badge">Saved Events</span>
    <h2 class="section-heading" style="color:#fff; margin-bottom:8px;">
      My <span class="hero-italic">Wishlist</span>
    </h2>

    <c:choose>
      <c:when test="${empty wishlistEvents}">
        <p class="empty-msg" style="font-size:1.1rem; padding:60px 0;">
          &#10084; Your wishlist is empty.
          <a href="${pageContext.request.contextPath}/Events"
             style="color:#5b8dee; text-decoration:none; margin-left:8px;">Browse Events</a>
        </p>
      </c:when>
      <c:otherwise>
        <p style="color:#94a3b8; margin-bottom:24px; font-size:0.9rem;">
          <strong style="color:#cbd5e1;">${wishlistEvents.size()}</strong> saved event(s)
        </p>
        <div class="events-grid">
          <c:forEach var="event" items="${wishlistEvents}">
            <div class="event-card-public">
              <div class="event-card-header">
                <span class="event-type-badge">
                  <c:out value="${event.eventType}"/>
                </span>
              </div>
              <div class="event-card-body">
                <div class="event-meta-row">
                  <span class="event-meta-icon" style="color:#94a3b8;">&#128205;</span>
                  <span style="color:#e2e8f0; font-size:0.88rem;"><c:out value="${event.venueName}"/></span>
                </div>
                <div class="event-meta-row">
                  <span class="event-meta-icon" style="color:#94a3b8;">&#128197;</span>
                  <span style="color:#e2e8f0; font-size:0.88rem;"><c:out value="${event.eventDate}"/></span>
                </div>
                <div class="event-meta-row">
                  <span class="event-meta-icon" style="color:#94a3b8;">&#128336;</span>
                  <span style="color:#e2e8f0; font-size:0.88rem;"><c:out value="${event.eventTime}"/></span>
                </div>
                <div class="event-price-row">
                  <span class="event-price-label" style="color:#64748b; font-size:0.75rem; text-transform:uppercase; letter-spacing:0.05em;">Price per seat</span>
                  <span class="event-price-value" style="color:#34d399; font-weight:700; font-size:1.05rem;">Rs. <c:out value="${event.eventPrice}"/></span>
                </div>
              </div>
              <div class="event-card-footer">
                <form action="${pageContext.request.contextPath}/Booking" method="post">
                  <input type="hidden" name="eventID" value="${event.eventID}">
                  <button type="submit" class="btn-book">Apply &amp; Book</button>
                </form>
                <form action="${pageContext.request.contextPath}/Wishlist" method="post">
                  <input type="hidden" name="action"  value="remove">
                  <input type="hidden" name="eventID" value="${event.eventID}">
                  <button type="submit" class="btn-wish">&#10006; Remove</button>
                </form>
              </div>
            </div>
          </c:forEach>
        </div>

        <div style="margin-top:32px; display:flex; gap:16px; align-items:center;">
          <form action="${pageContext.request.contextPath}/Wishlist" method="post">
            <input type="hidden" name="action" value="clear">
            <button type="submit" class="btn-search"
                    onclick="return confirmDelete('Clear your entire wishlist?')"
                    style="background:#ef4444;">
              &#128465; Clear All
            </button>
          </form>
          <a href="${pageContext.request.contextPath}/Events" class="btn-search-clear">
            &larr; Back to Events
          </a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</section>

<footer class="footer">
  <div>
    <p class="footer-brand">BookYourEvents</p>
    <p class="footer-copy">&copy; 2026 BookYourEvents. The Art of Celebration.</p>
  </div>
  <div class="footer-right">
    <a href="${pageContext.request.contextPath}/Events">Events</a>
    <a href="${pageContext.request.contextPath}/Venues">Venues</a>
    <a href="${pageContext.request.contextPath}/About">About</a>
    <a href="${pageContext.request.contextPath}/Contact">Contact</a>
  </div>
</footer>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
