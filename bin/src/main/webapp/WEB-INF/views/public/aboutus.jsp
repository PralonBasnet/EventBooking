<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us — BookYourEvents</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
</head>
<body>

<c:set var="activeNav" value="about" scope="request"/>
<%@ include file="/WEB-INF/views/includes/navbar-public.jspf" %>

<!-- ABOUT HERO -->
<section class="about-hero">
    <span class="badge">Who We Are</span>
    <h1>The Art of <span>Extraordinary</span></h1>
    <p>
        We are a passionate team of event curators dedicated to transforming
        your vision into unforgettable experiences.
    </p>
</section>

<!-- OUR STORY -->
<section class="story-section">
    <div class="story-inner">
        <div class="story-text">
            <span class="badge">Our Story</span>
            <h2>From Vision to <span>Reality</span></h2>
            <p>
                BookYourEvents was built to make booking great venues and events
                simple, transparent, and enjoyable.
            </p>
            <p>
                We specialise in curating bespoke experiences for corporate
                conferences, intimate weddings, charity galas, and everything
                in between.
            </p>
        </div>
        <div class="story-image">
            <img src="${pageContext.request.contextPath}/images/event1.jpg"
                 alt="Our Story">
        </div>
    </div>
</section>

<!-- CORE VALUES -->
<section class="values-section">
    <span class="badge">What We Stand For</span>
    <h2 class="section-heading">Our Core <span class="blue-text">Values</span></h2>
    <p class="section-subheading">The principles that guide everything we do</p>
    <div class="values-grid">
        <div class="value-card">
            <div class="value-icon">&#10024;</div>
            <h3>Excellence</h3>
            <p>We hold ourselves to the highest standards in every detail.</p>
        </div>
        <div class="value-card">
            <div class="value-icon">&#128161;</div>
            <h3>Creativity</h3>
            <p>Every event is a blank canvas. We bring fresh ideas to life.</p>
        </div>
        <div class="value-card">
            <div class="value-icon">&#129309;</div>
            <h3>Trust</h3>
            <p>We build lasting relationships through transparency and reliability.</p>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="cta-section">
    <div class="cta-box">
        <h2>Ready to Create Something Extraordinary?</h2>
        <p>Browse our upcoming events and book your seat today.</p>
        <div class="cta-buttons">
            <a href="${pageContext.request.contextPath}/Register"
               class="btn-hero-primary">Get Started</a>
            <a href="${pageContext.request.contextPath}/Events"
               class="btn-hero-secondary">View Events</a>
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
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
