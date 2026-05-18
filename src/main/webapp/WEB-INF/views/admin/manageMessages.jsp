<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Messages — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageEvents.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageUsers.css">
</head>
<body class="admin-body">

<c:set var="activeNav" value="messages" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main">
  <section class="header">
    <div>
      <h1 class="title">Contact Messages</h1>
      <p class="subtitle">Review and resolve public inquiries</p>
    </div>
  </section>

  <c:if test="${param.success eq 'resolve'}">
    <div class="msg success">Message marked as resolved.</div>
  </c:if>
  <c:if test="${param.success eq 'reopen'}">
    <div class="msg success">Message reopened.</div>
  </c:if>
  <c:if test="${param.error eq 'update_failed'}">
    <div class="msg error">Update failed. Please try again.</div>
  </c:if>

  <div class="table-wrap">
    <table class="table">
      <thead>
        <tr>
          <th>#</th><th>Name</th><th>Email</th><th>Message</th><th>Status</th><th>Received</th><th>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty messages}">
            <tr><td colspan="7" class="empty-msg">No messages yet.</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="m" items="${messages}" varStatus="s">
              <tr>
                <td><c:out value="${s.index + 1}"/></td>
                <td><c:out value="${m.name}"/></td>
                <td><c:out value="${m.email}"/></td>
                <td style="max-width:320px; word-break:break-word;"><c:out value="${m.message}"/></td>
                <td>
                  <span class="status-badge status-${m.status}">
                    <c:out value="${m.status}"/>
                  </span>
                </td>
                <td><c:out value="${m.createdAt}"/></td>
                <td>
                  <c:choose>
                    <c:when test="${m.status eq 'OPEN'}">
                      <form action="${pageContext.request.contextPath}/admin/messages" method="post" style="display:inline">
                        <input type="hidden" name="action"    value="resolve">
                        <input type="hidden" name="messageID" value="${m.messageID}">
                        <button type="submit" class="btn-activate">Resolve</button>
                      </form>
                    </c:when>
                    <c:otherwise>
                      <form action="${pageContext.request.contextPath}/admin/messages" method="post" style="display:inline">
                        <input type="hidden" name="action"    value="reopen">
                        <input type="hidden" name="messageID" value="${m.messageID}">
                        <button type="submit" class="btn-suspend">Reopen</button>
                      </form>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
