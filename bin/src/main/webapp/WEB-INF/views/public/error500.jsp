<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Server Error — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: #0f0f1a; color: #fff; display: flex; flex-direction: column;
           align-items: center; justify-content: center; min-height: 100vh;
           font-family: 'Segoe UI', Arial, sans-serif; text-align: center; }
    .code { font-size: 8rem; font-weight: 800; color: #f59e0b; line-height: 1; }
    h2   { font-size: 1.6rem; margin: 16px 0 8px; }
    p    { color: #94a3b8; margin-bottom: 32px; }
    .btn { background: #f59e0b; color: #fff; padding: 12px 32px;
           border-radius: 8px; text-decoration: none; font-weight: 700;
           transition: background 0.2s; }
    .btn:hover { background: #d97706; }
  </style>
</head>
<body>
  <div class="code">500</div>
  <h2>Something Went Wrong</h2>
  <p>We encountered an unexpected error. Please try again shortly.</p>
  <a href="${pageContext.request.contextPath}/" class="btn">Go Home</a>
</body>
</html>
