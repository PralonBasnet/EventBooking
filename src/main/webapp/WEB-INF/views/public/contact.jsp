<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
</head>
<body>

<c:set var="activeNav" value="contact" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<!-- CONTACT CONTENT -->
<section class="contact-section">
  <div class="contact-inner">

    <div class="contact-info">
      <span class="badge">Get in Touch</span>
      <h2>We'd Love to Hear<br>From You</h2>
      <p>Have a question about booking an event or partnering with us?
         Send us a message and we'll get back to you within 24 hours.</p>

      <div class="contact-details">
        <p><strong>Email:</strong> hello@bookyourevents.com</p>
        <p><strong>Phone:</strong> +977 01-4440000</p>
        <p><strong>Address:</strong> Heritage Road, Kathmandu, Nepal</p>
      </div>
    </div>

    <div class="contact-form-wrap">
      <c:if test="${not empty successMsg}">
        <div class="contact-success"><c:out value="${successMsg}"/></div>
      </c:if>
      <c:if test="${not empty errorMsg}">
        <div class="contact-error"><c:out value="${errorMsg}"/></div>
      </c:if>

      <form class="contact-form" action="${pageContext.request.contextPath}/Contact" method="post">
        <div class="form-group">
          <label for="contactName">Your Name</label>
          <input type="text" id="contactName" name="name"
                 placeholder="Full Name" required
                 value="<c:out value='${formName}'/>">
        </div>
        <div class="form-group">
          <label for="contactEmail">Email Address</label>
          <input type="email" id="contactEmail" name="email"
                 placeholder="name@example.com" required
                 value="<c:out value='${formEmail}'/>">
        </div>
        <div class="form-group">
          <label for="contactMessage">Message</label>
          <textarea id="contactMessage" name="message" rows="5"
                    placeholder="Tell us about your enquiry..." required><c:out value="${formMessage}"/></textarea>
        </div>
        <button type="submit" class="btn-submit">Send Message &rarr;</button>
      </form>
    </div>

  </div>
</section>

<!-- FOOTER JSP -->
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
