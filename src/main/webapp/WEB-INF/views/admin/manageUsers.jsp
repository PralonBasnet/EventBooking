<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Users — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageEvents.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageUsers.css">
</head>
<body class="admin-body">

<c:set var="activeNav" value="users" scope="request"/>

<!-- Reusable admin navbar -->
<%@ include file="/WEB-INF/views/includes/navbar-admin.jspf" %>

<main class="main">
  <section class="header">
    <div>
      <h1 class="title">Manage Users</h1>
      <p class="subtitle">Activate, suspend, or review all accounts</p>
    </div>
  </section>
<!-- Success message after updating user status -->
  <c:if test="${param.success eq 'updated'}">
    <div class="msg success">User status updated.</div>
  </c:if>
  
  <!-- Error message if update fails -->
  <c:if test="${param.error eq 'update_failed'}">
    <div class="msg error">Status update failed. Please try again.</div>
  </c:if>

<!-- User Table Container -->
  <div class="table-wrap">
    <table class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>Full Name</th>
          <th>Username</th>
          <th>Email</th>
          <th>Role</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty users}">
            <tr>
              <td colspan="7" class="empty-msg">No users found.</td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="u" items="${users}" varStatus="s">
              <tr>
                <td><c:out value="${s.index + 1}"/></td>
                <td><c:out value="${u.fullName}"/></td>
                <td><c:out value="${u.userName}"/></td>
                <td><c:out value="${u.email}"/></td>
                <td>
                  <span class="role-badge role-${u.userRole}">
                    <c:out value="${u.userRole}"/>
                  </span>
                </td>
                <td>
                  <span class="status-badge status-${u.userStatus}">
                    <c:out value="${u.userStatus}"/>
                  </span>
                </td>
                
                <!-- Admin action buttons -->
                
                <td>
                  <c:if test="${u.userID ne sessionScope.user.userID}">
                    <c:choose>
                      <c:when test="${u.userStatus eq 'ACTIVE'}">
                        <form action="${pageContext.request.contextPath}/admin/users"
                              method="post" style="display:inline">
                          <input type="hidden" name="action" value="updateStatus">
                          <input type="hidden" name="userID" value="${u.userID}">
                          <input type="hidden" name="targetStatus" value="SUSPENDED">
                          <button type="submit" class="btn-suspend"
                                  onclick="return confirm('Suspend this user?')">
                            Suspend
                          </button>
                        </form>
                      </c:when>
                      <c:otherwise>
                        <form action="${pageContext.request.contextPath}/admin/users"
                              method="post" style="display:inline">
                          <input type="hidden" name="action" value="updateStatus">
                          <input type="hidden" name="userID" value="${u.userID}">
                          <input type="hidden" name="targetStatus" value="ACTIVE">
                          <button type="submit" class="btn-activate">
                            Activate
                          </button>
                        </form>
                      </c:otherwise>
                    </c:choose>
                      <!-- Allow admin promotion only for non-admin users -->
                    <c:if test="${u.userRole ne 'ADMIN'}">
                      <form action="${pageContext.request.contextPath}/admin/users"
                            method="post" style="display:inline; margin-top:6px;">
                        <input type="hidden" name="action" value="updateRole">
                        <input type="hidden" name="userID" value="${u.userID}">
                        <input type="hidden" name="targetRole" value="ADMIN">
                        <button type="submit" class="btn-promote"
                                onclick="return confirm('Promote this user to Admin?')">
                          Make Admin
                        </button>
                      </form>
                    </c:if>
                  </c:if>
                  <c:if test="${u.userID eq sessionScope.user.userID}">
                    <span class="self-label">You</span>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</main>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
