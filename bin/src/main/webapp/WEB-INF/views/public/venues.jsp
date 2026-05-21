<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Venues — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/venues.css">
</head>
<body class="venues-body">

<c:set var="activeNav" value="venues" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<!-- PAGE HEADER -->
<section class="venues-hero">
  <div class="venues-hero-inner">
    <span class="badge">Our Spaces</span>
    <h1 class="section-heading" style="color:#f1f5f9 !important;">
      Discover Our <span class="blue-text">Venues</span>
    </h1>
    <p class="section-subheading">
      Hand-curated spaces for every occasion — from intimate gatherings to grand celebrations.
    </p>
  </div>
</section>

<!-- VENUES GRID -->
<section class="venues-section">
  <div class="venues-inner">

    <c:if test="${not empty venuesError}">
      <p class="venues-error"><c:out value="${venuesError}"/></p>
    </c:if>

    <c:choose>
      <c:when test="${empty venues}">
        <p class="venues-empty">No venues available at the moment. Check back soon!</p>
      </c:when>
      <c:otherwise>
        <div class="venues-grid">
          <c:forEach var="venue" items="${venues}">
            <c:set var="ctx" value="${pageContext.request.contextPath}"/>
            <div class="venue-card">
              <div class="venue-card-header">
                <div class="venue-icon">&#127968;</div>
                <div>
                  <h3 class="venue-name"><c:out value="${venue.venueName}"/></h3>
                  <p class="venue-tagline" style="color:#94a3b8; font-size:0.82rem; line-height:1.5; margin-top:4px;">
                    <c:choose>
                      <c:when test="${venue.venueCapacity ge 400}">
                        Grand hall ideal for galas, weddings and large conferences.
                      </c:when>
                      <c:when test="${venue.venueCapacity ge 150}">
                        Mid-size venue perfect for corporate events and celebrations.
                      </c:when>
                      <c:otherwise>
                        Intimate space suited for workshops, seminars and private events.
                      </c:otherwise>
                    </c:choose>
                  </p>
                </div>
              </div>
              <div class="venue-card-body">
                <div class="venue-detail">
                  <span class="venue-detail-label">Capacity</span>
                  <span class="venue-detail-value">
                    <c:out value="${venue.venueCapacity}"/> guests
                  </span>
                </div>
                <div class="venue-detail">
                  <span class="venue-detail-label">Contact</span>
                  <span class="venue-detail-value">
                    <c:out value="${venue.venueContact}"/>
                  </span>
                </div>
                <div class="venue-detail">
                  <span class="venue-detail-label">Address</span>
                  <span class="venue-detail-value">
                    <c:out value="${venue.venueAddress}"/>
                  </span>
                </div>
              </div>
              <div class="venue-card-footer">
                <a href="${ctx}/Events?q=${venue.venueName}" class="btn-venue-primary"
                   style="display:inline-block; background:#5b8dee; color:#fff !important; padding:10px 20px; border-radius:8px; font-weight:700; font-size:0.88rem; text-decoration:none;">
                  View Events Here
                </a>
                <a href="${ctx}/Contact" class="btn-venue-secondary"
                   style="display:inline-block; background:transparent; color:#94a3b8 !important; border:1px solid rgba(255,255,255,0.2); padding:10px 20px; border-radius:8px; font-size:0.88rem; text-decoration:none;">
                  Contact Us
                </a>
              </div>
            </div>
          </c:forEach>
        </div>

        <!-- What to Expect strip -->
        <div class="venue-info-strip" style="display:grid; grid-template-columns:repeat(3,1fr); gap:24px; margin-top:48px;">
          <div class="venue-info-card" style="background:#1a1a2e; border:1px solid rgba(91,141,238,0.25); border-radius:14px; padding:28px 24px; text-align:center;">
            <div class="venue-info-icon" style="font-size:2rem; margin-bottom:12px;">&#127881;</div>
            <h4 style="color:#f1f5f9; font-size:1rem; font-weight:700; margin-bottom:8px;">Full Event Support</h4>
            <p style="color:#94a3b8; font-size:0.85rem; line-height:1.6;">Our team coordinates with each venue to ensure seamless event execution.</p>
          </div>
          <div class="venue-info-card" style="background:#1a1a2e; border:1px solid rgba(91,141,238,0.25); border-radius:14px; padding:28px 24px; text-align:center;">
            <div class="venue-info-icon" style="font-size:2rem; margin-bottom:12px;">&#128205;</div>
            <h4 style="color:#f1f5f9; font-size:1rem; font-weight:700; margin-bottom:8px;">Prime Locations</h4>
            <p style="color:#94a3b8; font-size:0.85rem; line-height:1.6;">All venues are centrally located in Kathmandu Valley with easy access.</p>
          </div>
          <div class="venue-info-card" style="background:#1a1a2e; border:1px solid rgba(91,141,238,0.25); border-radius:14px; padding:28px 24px; text-align:center;">
            <div class="venue-info-icon" style="font-size:2rem; margin-bottom:12px;">&#128222;</div>
            <h4 style="color:#f1f5f9; font-size:1rem; font-weight:700; margin-bottom:8px;">Direct Contact</h4>
            <p style="color:#94a3b8; font-size:0.85rem; line-height:1.6;">Reach out to our team or the venue directly for custom requirements.</p>
          </div>
        </div>

      </c:otherwise>
    </c:choose>
  </div>
</section>
<!-- FOOTER -->
<footer class="footer">
  <div>
    <p class="footer-brand">BookYourEvents</p>
    <p class="footer-copy">&copy; 2026 BookYourEvents. Crafting extraordinary moments since 2026.</p>
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
