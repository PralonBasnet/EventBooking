<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Events — BookYourEvents</title>

  <!-- External CSS file -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageEvents.css">
</head>
<body class="admin-body">

<c:set var="activeNav" value="events" scope="request"/>

<!-- Admin navbar -->
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main">
  <section class="header">
    <div>
      <h1 class="title">Manage Events</h1>
      <p class="subtitle">Create, edit, or remove events</p>
    </div>

    <!-- Button to add new event -->
    <a href="${pageContext.request.contextPath}/admin/events?action=add" class="btn">
      + Add Event
    </a>
  </section>

  <!-- Success and error messages -->
  <c:if test="${param.success eq 'added'}">
    <div class="msg success">Event added successfully.</div>
  </c:if>

  <c:if test="${param.success eq 'updated'}">
    <div class="msg success">Event updated successfully.</div>
  </c:if>

  <c:if test="${param.success eq 'deleted'}">
    <div class="msg success">Event deleted.</div>
  </c:if>

  <c:if test="${not empty error}">
    <div class="msg error"><c:out value="${error}"/></div>
  </c:if>

  <div class="table-wrap">
    <table class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>Type</th>
          <th>Venue</th>
          <th>Date</th>
          <th>Time</th>
          <th>Price (Rs.)</th>
          <th>Actions</th>
        </tr>
      </thead>

      <tbody>
        <c:choose>

          <!-- If no events exist -->
          <c:when test="${empty events}">
            <tr>
              <td colspan="7" class="empty-msg">
                No events found. Add your first event.
              </td>
            </tr>
          </c:when>

          <c:otherwise>

            <!-- Loop through events -->
            <c:forEach var="event" items="${events}" varStatus="s">
              <tr>

                <!-- Serial number -->
                <td><c:out value="${s.index + 1}"/></td>

                <td>
                  <span class="badge">
                    <c:out value="${event.eventType}"/>
                  </span>
                </td>

                <td><c:out value="${event.venueName}"/></td>
                <td><c:out value="${event.eventDate}"/></td>
                <td><c:out value="${event.eventTime}"/></td>
                <td><c:out value="${event.eventPrice}"/></td>

                <td class="actions">

                  <!-- Edit event -->
                  <a class="btn-edit"
                     href="${pageContext.request.contextPath}/admin/events?action=edit&id=${event.eventID}">
                    &#9999; Edit
                  </a>

                  <!-- Delete event form -->
                  <form action="${pageContext.request.contextPath}/admin/events"
                        method="post"
                        style="display:inline"
                        onsubmit="return confirmDelete('Delete this event? It will be hidden but kept for audit.')">

                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${event.eventID}">

                    <button type="submit" class="btn-delete">
                      &#128465; Delete
                    </button>
                  </form>

                </td>
              </tr>
            </c:forEach>

          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</main>

<!-- JavaScript file -->
<script src="${pageContext.request.contextPath}/js/app.js"></script>

</body>
</html>