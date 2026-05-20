<%@ page language="java" 
         contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" 
          content="width=device-width, initial-scale=1.0">
    <title>BookYourEvents - The Art of Extraordinary Events</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/favicon.svg">
    <link rel="stylesheet" 
          href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" 
          href="${pageContext.request.contextPath}/css/landing.css">
</head>
<body>

<%-- NAVBAR --%>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="nav-brand-link" style="color:#fff !important; font-weight:800; text-decoration:none;">BookYourEvents</a>
    <div class="nav-center">
        <a href="${pageContext.request.contextPath}/Events"  class="nav-link">Events</a>
        <a href="${pageContext.request.contextPath}/Venues"  class="nav-link">Venues</a>
        <a href="${pageContext.request.contextPath}/About"   class="nav-link">About</a>
        <a href="${pageContext.request.contextPath}/Contact" class="nav-link">Contact</a>
    </div>
<div class="nav-right">
    <a href="${pageContext.request.contextPath}/Login"    class="nav-link">Sign In</a>
    <a href="${pageContext.request.contextPath}/Contact"  class="btn-contact">Contact us</a>
</div>
</nav>

<section class="hero-section">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1 class="hero-title">
            The Art of<br>
            <span class="hero-italic">Extraordinary</span><br>
            Events
        </h1>
        <p class="hero-subtitle">
            We turn your vision into unforgettable
            experiences; from intimate celebrations
            to global summits.
        </p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/Register"
               class="btn-hero-primary">Get Started</a>
            <a href="${pageContext.request.contextPath}/Events"
               class="btn-hero-secondary">Browse Events</a>
        </div>
    </div>
</section>

<%-- PROCESS SECTION --%>
<section class="process-section" id="services">
    <div class="process-inner">
        <span class="badge">How We Work</span>
        <h2 class="section-heading">
            Our <span class="blue-text">Signature</span> Process
        </h2>
        <p class="section-subheading">
            "From vision to unforgettable reality,
            every single step is crafted with precision and care"
        </p>
        <div class="process-grid">
            <div class="process-card">
                <p class="process-num blue-text">
                    01. Discovery &amp; Vision
                </p>
                <p class="process-desc">
                    Deep listening to understand your dreams
                    and unique requirements.
                </p>
            </div>
            <div class="process-card">
                <p class="process-num blue-text">
                    02. Concept &amp; Design
                </p>
                <p class="process-desc">
                    Creative development of mood boards,
                    themes, and detailed designs.
                </p>
            </div>
            <div class="process-card">
                <p class="process-num blue-text">
                    03. Curation &amp; Production
                </p>
                <p class="process-desc">
                    Hand-selection of venues, vendors,
                    and bespoke elements.
                </p>
            </div>
            <div class="process-card">
                <p class="process-num blue-text">
                    04. Execution &amp; Magic
                </p>
                <p class="process-desc">
                    Seamless delivery so you can simply
                    enjoy the extraordinary.
                </p>
            </div>
        </div>
    </div>
</section>

<%-- GALLERY SECTION --%>
<section class="gallery-section" id="gallery">
    <div class="gallery-layout">

        <%-- Heading inside the box --%>
        <div class="gallery-heading">
            <span class="badge">What we Create</span>
            <h2 class="section-heading">
                A Glimpse into Our
                <span class="blue-text">Curated</span> Moments
            </h2>
        </div>

        <%-- Images row --%>
        <div class="gallery-images">
            <div class="gallery-left">
                <img src="${pageContext.request.contextPath}/images/event1.jpg"
                     alt="Curated Event 1">
            </div>
            <div class="gallery-right">
                <img src="${pageContext.request.contextPath}/images/event2.jpg"
                     alt="Curated Event 2">
                <div class="testimonial-box">
                    <p class="quote-marks">&rdquo;K.P. Oli&rdquo;</p>
                    <p class="testimonial-text">
                        "A masterclass in versatility. They don't
                        just host events; they breathe life into
                        our most ambitious visions."
                    </p>
                </div>
            </div>
        </div>

    </div>
</section>

<%-- CTA SECTION --%>
<section class="cta-section">
    <div class="cta-box">
        <h2>Your Vision, Our Space.</h2>
        <p>
            Whether it's an conference meeting or a grand wedding,
            our venue provides the perfect canvas for your
            most ambitious ideas. Let's make it happen.
        </p>
        <div class="cta-buttons">
            <a href="${pageContext.request.contextPath}/Register"
               class="btn-hero-primary">Get Started</a>
            <a href="${pageContext.request.contextPath}/Contact"
               class="btn-hero-secondary">Contact Us</a>
        </div>
    </div>
</section>

<%-- FOOTER --%>
<footer class="footer">
    <div>
        <p class="footer-brand">BookYourEvents</p>
        <p class="footer-copy">
            &copy; 2026 BookYourEvents: Celebrating the art of celebration
        </p>
    </div>
    <div class="footer-right">
        <a href="${pageContext.request.contextPath}/Events">Events</a>
        <a href="${pageContext.request.contextPath}/Venues">Venues</a>
        <a href="${pageContext.request.contextPath}/About">About</a>
        <a href="${pageContext.request.contextPath}/Contact">Contact</a>
    </div>
</footer>

</body>
</html>