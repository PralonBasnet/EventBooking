<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Account — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
</head>
<body>

<div class="card">

  <!-- Left panel: brand ko image -->
  <div class="panel-left">
    <img src="${pageContext.request.contextPath}/images/signup_venue.png"
         class="venue-img" alt="Venue">
    <div class="panel-text">
      <h1>Create<br>Extraordinary<br>Events</h1>
      <p>Where elegance meets every celebration.<br>
         Unforgettable memories begin here.</p>
    </div>
  </div>

  <!-- Right panel: registration form -->
  <div class="panel-right">

    <p class="tagline">The Experience begins here.</p>
    <h2>Create Your Account.</h2>

    <c:if test="${not empty errorMsg}">
      <p class="error-msg"><c:out value="${errorMsg}"/></p>
    </c:if>

    <!-- field names match RegisterServlet parameter reads exactly -->
    <form action="${pageContext.request.contextPath}/Register" method="post">

      <!-- Full name spans the full width at the top -->
      <div class="form-row">
        <div class="form-group full-width">
          <label for="fullName">FULL NAME</label>
          <input type="text"
                 id="fullName"
                 name="fullName"
                 value="${not empty formFullName ? formFullName : ''}"
                 placeholder="Your full name (no numbers)"
                 required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="userName">USERNAME</label>
          <input type="text"
                 id="userName"
                 name="userName"
                 value="${not empty formUserName ? formUserName : ''}"
                 placeholder="No spaces allowed"
                 required>
        </div>
        <div class="form-group">
          <label for="email">EMAIL</label>
          <input type="email"
                 id="email"
                 name="email"
                 value="${not empty formEmail ? formEmail : ''}"
                 required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="contactNumber">CONTACT NUMBER</label>
          <input type="text"
                 id="contactNumber"
                 name="contactNumber"
                 value="${not empty formContactNumber ? formContactNumber : ''}"
                 placeholder="e.g. 9800000000"
                 required>
        </div>
        <div class="form-group">
          <label for="password">PASSWORD</label>
          <input type="password"
                 id="password"
                 name="password"
                 minlength="6"
                 placeholder="Min. 6 characters"
                 required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group full-width">
          <label for="dateOfBirth">DATE OF BIRTH</label>
          <input type="date"
                 id="dateOfBirth"
                 name="dateOfBirth"
                 value="${not empty formDateOfBirth ? formDateOfBirth : ''}"
                 required>
        </div>
      </div>

      <button type="submit" class="btn-primary">Create my Account &rarr;</button>

    </form>

    <p class="signin-link">
      Already have an account?
      <a href="${pageContext.request.contextPath}/Login">Sign In</a>
    </p>

  </div>
</div>

</body>
</html>
