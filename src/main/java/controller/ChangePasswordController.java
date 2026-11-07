package controller;

import java.io.IOException;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;

        }

        request.getRequestDispatcher("/user/change-password.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("user");

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {

            request.setAttribute("error",
                    "Xác nhận mật khẩu không khớp.");

            doGet(request, response);
            return;

        }

        boolean success = userDAO.changePassword(
                user.getUsername(),
                oldPassword,
                newPassword);

        if (!success) {

            request.setAttribute("error",
                    "Mật khẩu cũ không đúng.");

            doGet(request, response);
            return;

        }

        user.setPassword(newPassword);
        session.setAttribute("user", user);

        request.setAttribute("success",
                "Đổi mật khẩu thành công.");

        doGet(request, response);

    }

}