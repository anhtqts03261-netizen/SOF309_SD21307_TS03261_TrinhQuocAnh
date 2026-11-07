package controller;

import java.io.IOException;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User account = userDAO.checkLogin(username, password);

        if (account == null) {

            request.setAttribute("error",
                    "Sai tên đăng nhập hoặc mật khẩu!");

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

            return;
        }

        // Kiểm tra tài khoản còn hoạt động không
        if (Boolean.FALSE.equals(account.getIsActive())) {

            request.setAttribute("error",
                    "Tài khoản đã bị khóa!");

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

            return;
        }

        // Tạo Session mới
        request.getSession().invalidate();

        HttpSession session = request.getSession(true);

        session.setAttribute("user", account);

        switch (account.getRole()) {

            case "ADMIN":

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/dashboard");

                break;

            case "WAITER":

                response.sendRedirect(
                        request.getContextPath()
                                + "/waiter/dashboard");

                break;

            case "CHEF":

                response.sendRedirect(
                        request.getContextPath()
                                + "/kitchen/dashboard");

                break;

            case "STOREKEEPER":

                response.sendRedirect(
                        request.getContextPath()
                                + "/storekeeper/dashboard");

                break;

            case "CASHIER":

                response.sendRedirect(
                        request.getContextPath()
                                + "/cashier/dashboard");

                break;

            default:

                session.invalidate();

                response.sendRedirect(
                        request.getContextPath()
                                + "/login");

        }

    }

}