<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Events — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/events.css">
</head>
<body class="events-body">

<c:set var="activeNav" value="events" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<!-- Dark hero strip -->
<div class="events-hero">
  <h1>Upcoming <span class="hero-italic">Events</span></h1>
  <p>Find and book events that match your style</p>
</div>

<!-- Search + events grids -->
<section class="events-section">
  <div class="events-inner">

    <form action="${pageContext.request.contextPath}/Events" method="get" class="search-form">
      <input type="text" name="q" placeholder="Search by type or venue..."
             value="${not empty searchQ ? searchQ : ''}" class="search-input">
      <select name="type" class="search-select">
        <option value="">All Types</option>
        <option value="Conference" ${searchType eq 'Conference' ? 'selected' : ''}>Conference</option>
        <option value="Fundraiser" ${searchType eq 'Fundraiser' ? 'selected' : ''}>Fundraiser</option>
        <option value="Gala"       ${searchType eq 'Gala'       ? 'selected' : ''}>Gala</option>
        <option value="Wedding"    ${searchType eq 'Wedding'    ? 'selected' : ''}>Wedding</option>
        <option value="Corporate"  ${searchType eq 'Corporate'  ? 'selected' : ''}>Corporate</option>
        <option value="Concert"    ${searchType eq 'Concert'    ? 'selected' : ''}>Concert</option>
        <option value="Workshop"   ${searchType eq 'Workshop'   ? 'selected' : ''}>Workshop</option>
        <option value="Other"      ${searchType eq 'Other'      ? 'selected' : ''}>Other</option>
      </select>
      <select name="venueID" class="search-select">
        <option value="">All Venues</option>
        <c:forEach var="v" items="${venues}">
          <option value="${v.venueID}" ${searchVenueID eq v.venueID ? 'selected' : ''}>
            <c:out value="${v.venueName}"/>
          </option>
        </c:forEach>
      </select>
      <input type="date" name="from" value="${not empty searchFrom ? searchFrom : ''}"
             class="search-date" title="From date">
      <input type="date" name="to"   value="${not empty searchTo   ? searchTo   : ''}"
             class="search-date" title="To date">
      <button type="submit" class="btn-search">Search</button>
      <a href="${pageContext.request.contextPath}/Events" class="btn-search-clear">Clear</a>
    </form>

    <c:if test="${not empty events}">
      <p class="results-count">
        Showing <strong>${events.size()}</strong> event(s)<c:if test="${not empty searchQ or not empty searchType}"> for your search</c:if>
      </p>
    </c:if>

    <c:if test="${not empty eventsError}">
      <p class="empty-msg"><c:out value="${eventsError}"/></p>
    </c:if>

    <c:choose>
      <c:when test="${empty events}">
        <p class="empty-msg">No events match your search. Try different filters!</p>
      </c:when>
      <c:otherwise>
        <div class="events-grid">
          <c:forEach var="event" items="${events}">
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
                <c:choose>
                  <c:when test="${not empty sessionScope.user}">
                    <form action="${pageContext.request.contextPath}/Booking" method="post" style="display:inline">
                      <input type="hidden" name="eventID" value="${event.eventID}">
                      <button type="submit" class="btn-book">Apply &amp; Book</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/Wishlist" method="post" style="display:inline">
                      <input type="hidden" name="action"  value="add">
                      <input type="hidden" name="eventID" value="${event.eventID}">
                      <button type="submit" class="btn-wish" title="Save to wishlist">&#10084; Save</button>
                    </form>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/Login" class="btn-book-ghost">
                      Sign in to Book
                    </a>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>

  </div>
</section>

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
