package com.c11.EventBooking.controller;

import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.service.AccountPendingException;
import com.c11.EventBooking.service.AccountSuspendedException;
import com.c11.EventBooking.service.LoginService;
import com.c11.EventBooking.util.CookieUtils;
import com.c11.EventBooking.util.SessionUtils;
import com.c11.EventBooking.util.StringUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Handles the login and session creation flow. */
@WebServlet("/Login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(LoginServlet.class.getName());

    private final LoginService loginService = new LoginService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        String remembered = CookieUtils.getCookie(request, "lastUsername");
        if (remembered != null) {
            request.setAttribute("rememberedUsername", remembered);
        }
        request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                   .forward(request, response);
            return;
        }

        try {
            UserModel user = loginService.authenticate(username, password);

            if (user != null) {
                if ("on".equals(request.getParameter("remember"))) {
                    CookieUtils.setCookie(response, "lastUsername", username, 7 * 24 * 3600);
                }

                SessionUtils.createUserSession(request, user);

                if ("ADMIN".equalsIgnoreCase(user.getUserRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/Home");
                }

            } else {
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.setAttribute("typedUsername", username);
                request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                       .forward(request, response);
            }

        } catch (AccountPendingException e) {
            request.setAttribute("errorMessage",
                    "Your account is awaiting admin approval. Please try again later.");
            request.setAttribute("typedUsername", username);
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                   .forward(request, response);

        } catch (AccountSuspendedException e) {
            request.setAttribute("errorMessage",
                    "Your account has been suspended. Please contact support.");
            request.setAttribute("typedUsername", username);
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Login attempt failed with unexpected error", e);
            request.setAttribute("errorMessage", "Something went wrong. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                   .forward(request, response);
        }
    }
}
