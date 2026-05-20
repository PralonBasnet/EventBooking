<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
</head>
<body>

<c:set var="activeNav" value="" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<!-- two-column layout — left avatar, right editable forms -->
<div class="profile-page">
  <div class="profile-layout">

    <!-- LEFT COLUMN: avatar -->
    <aside class="avatar-section">
      <div class="avatar-circle">
        <c:choose>
          <c:when test="${not empty sessionScope.user.profilePicture}">
            <img src="${pageContext.request.contextPath}/${sessionScope.user.profilePicture}"
                 alt="Profile photo" width="120" height="120">
          </c:when>
          <c:otherwise>
            <span class="avatar-letter"><c:out value="${avatarInitial}"/></span>
          </c:otherwise>
        </c:choose>
      </div>

      <p class="avatar-name"><c:out value="${sessionScope.user.fullName}"/></p>
      <p class="avatar-username">@<c:out value="${sessionScope.user.userName}"/></p>

      <label class="upload-label" for="profilePictureInput">
        &#128247; Change Photo
      </label>
    </aside>

    <!-- RIGHT COLUMN: profile info form + password change form -->
    <div class="profile-form-section">

      <!-- Profile info -->
      <h2>Your Profile</h2>
      <p class="subtitle">Update your account details below.</p>

      <c:if test="${not empty profileSuccess}">
        <div class="alert-success"><c:out value="${profileSuccess}"/></div>
      </c:if>
      <c:if test="${not empty profileError}">
        <div class="alert-error"><c:out value="${profileError}"/></div>
      </c:if>

      <form action="${pageContext.request.contextPath}/Profile"
            method="post"
            enctype="multipart/form-data">

        <input type="file"
               id="profilePictureInput"
               name="profilePicture"
               accept="image/*"
               class="hidden-file"
               onchange="this.form.submit()">

        <div class="form-group">
          <label for="fullName">Full Name</label>
          <input type="text" id="fullName" name="fullName"
                 value="${sessionScope.user.fullName}" required>
        </div>

        <div class="form-group">
          <label for="userName">Username</label>
          <input type="text" id="userName" name="userName"
                 value="${sessionScope.user.userName}" required>
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email"
                 value="${sessionScope.user.email}" required>
        </div>

        <div class="form-group">
          <label for="contactNumber">Contact Number</label>
          <input type="text" id="contactNumber" name="contactNumber"
                 value="${sessionScope.user.contactNumber}"
                 placeholder="Digits only" required>
        </div>

        <div class="form-group">
          <label for="dateOfBirth">Date of Birth</label>
          <input type="date" id="dateOfBirth" name="dateOfBirth"
                 value="${sessionScope.user.dateOfBirth}">
        </div>

        <div class="form-actions">
          <c:choose>
            <c:when test="${sessionScope.user.userRole eq 'ADMIN'}">
              <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-cancel">Cancel</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/Home" class="btn-cancel">Cancel</a>
            </c:otherwise>
          </c:choose>
          <button type="submit" class="btn-save">Save Changes</button>
        </div>

      </form>

      <!-- Change password -->
      <hr class="section-divider">
      <h3 class="pwd-heading">Change Password</h3>

      <c:if test="${not empty pwdSuccess}">
        <div class="alert-success"><c:out value="${pwdSuccess}"/></div>
      </c:if>
      <c:if test="${not empty pwdError}">
        <div class="alert-error"><c:out value="${pwdError}"/></div>
      </c:if>

      <form action="${pageContext.request.contextPath}/Profile" method="post">
        <input type="hidden" name="action" value="changePassword">

        <div class="form-group">
          <label for="currentPassword">Current Password</label>
          <input type="password" id="currentPassword" name="currentPassword" required>
        </div>

        <div class="form-group">
          <label for="newPassword">New Password</label>
          <input type="password" id="newPassword" name="newPassword"
                 minlength="6" placeholder="Min. 6 characters" required>
        </div>

        <div class="form-group">
          <label for="confirmNewPassword">Confirm New Password</label>
          <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-save">Update Password</button>
        </div>

      </form>

    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
