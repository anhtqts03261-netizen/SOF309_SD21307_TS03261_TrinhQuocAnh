package controller.admin;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/user")
public class UserManagementController extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ================= XÓA ===================
        if ("delete".equals(action)) {

            String username = request.getParameter("username");

            // Không cho xóa admin
            if (!"admin".equalsIgnoreCase(username)) {
                userDAO.delete(username);
            }

            response.sendRedirect(request.getContextPath() + "/admin/user");
            return;
        }

        // ================= SỬA ===================
        if ("edit".equals(action)) {

            String username = request.getParameter("username");

            User user = userDAO.findById(username);

            request.setAttribute("editUser", user);
        }

        // ================= DANH SÁCH ===================
        List<User> list = userDAO.findAll();

        request.setAttribute("userList", list);

        request.getRequestDispatcher("/admin/user.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        boolean active =
                request.getParameter("isActive") != null;

        // ================= THÊM ===================
        if ("create".equals(action)) {

            if (userDAO.existsByUsername(username)) {

                request.setAttribute("message",
                        "Username đã tồn tại!");

            } else {

                User user = new User();

                user.setUsername(username);
                user.setPassword(password);
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setRole(role);
                user.setIsActive(active);

                userDAO.insert(user);

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/user");

                return;
            }

        }

        // ================= CẬP NHẬT ===================
        if ("update".equals(action)) {

            User user = userDAO.findById(username);

            if (user != null) {

                user.setPassword(password);
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setRole(role);
                user.setIsActive(active);

                userDAO.update(user);
            }

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/user");

            return;
        }

        doGet(request, response);
    }
}