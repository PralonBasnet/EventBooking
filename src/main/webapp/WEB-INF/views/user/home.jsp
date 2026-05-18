<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body class="home-body">

<c:set var="activeNav" value="home" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<!-- HERO -->
<section class="hero-section">
  <div class="hero-overlay"></div>
  <div class="hero-content">
    <h1 class="hero-title">
      The Art of<br>
      <span class="hero-italic">Extraordinary</span><br>
      Events
    </h1>
    <p class="hero-subtitle">
      Browse our upcoming events and book your seat today.
    </p>
    <a href="${pageContext.request.contextPath}/Events" class="btn-hero">Explore Events</a>
  </div>
</section>

<!-- MOST POPULAR EVENTS -->
<section class="popular-section">
  <div class="popular-inner">
    <span class="badge">Trending</span>
    <h2 class="section-heading"><span class="blue-text">Most Popular Events</span></h2>
    <c:choose>
      <c:when test="${empty popularEvents}">
        <p class="empty-msg">No booking data yet. Be the first to book!</p>
      </c:when>
      <c:otherwise>
        <div class="popular-grid">
          <c:forEach var="ev" items="${popularEvents}">
            <div class="popular-card">
              <span class="popular-type"><c:out value="${ev[0]}"/></span>
              <span class="popular-count"><c:out value="${ev[1]}"/> booking(s)</span>
              <a href="${pageContext.request.contextPath}/Events" class="btn-popular">View Events</a>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</section>

<!-- SERVICES STRIP -->
<section class="services-strip">
  <div class="services-grid">
    <div class="service-card">
      <div class="service-icon">&#127903;</div>
      <h4>Wide Event Range</h4>
      <p>From corporate conferences to grand weddings, find the perfect event for you.</p>
    </div>
    <div class="service-card">
      <div class="service-icon">&#128205;</div>
      <h4>Prime Kathmandu Venues</h4>
      <p>Handpicked venues across the valley, each designed for memorable occasions.</p>
    </div>
    <div class="service-card">
      <div class="service-icon">&#128274;</div>
      <h4>Secure Booking</h4>
      <p>Your reservations are safely handled with instant confirmation and clear status updates.</p>
    </div>
    <div class="service-card">
      <div class="service-icon">&#128222;</div>
      <h4>Dedicated Support</h4>
      <p>Our team is ready to help you find the right event and answer any questions.</p>
    </div>
  </div>
</section>

<!-- GALLERY -->
<section class="gallery-section" id="gallery">
  <div class="gallery-layout">
    <div class="gallery-heading">
      <span class="badge">What We Create</span>
      <h2 class="section-heading">
        A Glimpse into Our <span class="blue-text">Curated</span> Moments
      </h2>
    </div>
    <div class="gallery-images">
      <div class="gallery-left">
        <img src="${pageContext.request.contextPath}/images/event1.jpg" alt="Curated Event 1">
      </div>
      <div class="gallery-right">
        <img src="${pageContext.request.contextPath}/images/event2.jpg" alt="Curated Event 2">
        <div class="testimonial-box">
          <p class="testimonial-text">
            "A masterclass in versatility. They don't just host events;
            they breathe life into our most ambitious visions."
          </p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
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
    <c:if test="${not empty sessionScope.user}">
      <a href="${pageContext.request.contextPath}/Logout">Sign Out</a>
    </c:if>
  </div>
</footer>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
