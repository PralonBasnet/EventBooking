<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In — BookYourEvents</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>

<div class="main-card">
    <div class="login-card">

        <h1>Welcome Back</h1>
        <p class="subtitle">Sign in to manage your extraordinary events.</p>

        <!-- Success message after registration -->
        <c:if test="${param.registered eq 'true'}">
            <p class="success-message">Account created! Please wait for admin approval before signing in.</p>
        </c:if>

        <!-- Session invalidated because account status changed while user was active -->
        <c:if test="${param.suspended eq 'true'}">
            <p class="warning-message">Your session was ended because your account status changed. Please contact support if you believe this is an error.</p>
        </c:if>

        <!-- Error messages from LoginServlet -->
        <c:if test="${not empty errorMessage}">
            <p class="error-message"><c:out value="${errorMessage}"/></p>
        </c:if>

        <form action="${pageContext.request.contextPath}/Login" method="post">

            <div class="input-group">
                <label for="username">USERNAME</label>
                <input type="text"
                       id="username"
                       name="username"
                       value="${not empty typedUsername ? typedUsername : (not empty rememberedUsername ? rememberedUsername : '')}"
                       required>
            </div>

            <div class="input-group">
                <label for="password">PASSWORD</label>
                <input type="password"
                       id="password"
                       name="password"
                       required>
            </div>

            <div class="remember-row">
              <label class="remember-label">
                <input type="checkbox" name="remember"
                       ${not empty rememberedUsername ? 'checked' : ''}> Remember my username
              </label>
            </div>

            <button type="submit" class="login-btn">Sign In</button>

        </form>

        <p class="signup-link">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/Register">Create an Account</a>
        </p>

    </div>
</div>

</body>
</html>
