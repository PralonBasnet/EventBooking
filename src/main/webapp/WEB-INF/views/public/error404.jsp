<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Not Found — BookYourEvents</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    /* style for the whole page */
    body { background: #0f0f1a; color: #fff; display: flex; flex-direction: column;
           align-items: center; justify-content: center; min-height: 100vh;
           font-family: 'Segoe UI', Arial, sans-serif; text-align: center; }
    /* big 404 number */
    .code { font-size: 8rem; font-weight: 800; color: #ef4444; line-height: 1; }
    h2   { font-size: 1.6rem; margin: 16px 0 8px; }
    p    { color: #94a3b8; margin-bottom: 32px; }
    /* red button */
    .btn { background: #ef4444; color: #fff; padding: 12px 32px;
           border-radius: 8px; text-decoration: none; font-weight: 700;
           transition: background 0.2s; margin: 6px; display: inline-block; }
    .btn:hover { background: #dc2626; }
    /* second button style */
    .btn-ghost { background: transparent; color: #94a3b8; border: 1px solid rgba(255,255,255,0.2);
                 padding: 12px 32px; border-radius: 8px; text-decoration: none;
                 font-size: 0.9rem; margin: 6px; display: inline-block;
                 transition: color 0.2s, border-color 0.2s; }
    .btn-ghost:hover { color: #fff; border-color: rgba(255,255,255,0.5); }
  </style>
</head>
<body>
  <!-- 404 error page -->
  <div class="code">404</div>
  <h2>Page Not Found</h2>
  <p>The page you're looking for doesn't exist or has been moved.</p>
  <a href="${pageContext.request.contextPath}/" class="btn">Go Home</a>
  <a href="${pageContext.request.contextPath}/Events" class="btn-ghost">Browse Events</a>
</body>
</html>