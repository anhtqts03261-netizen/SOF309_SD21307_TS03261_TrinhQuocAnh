package controller;

import java.io.File;
import java.io.IOException;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import util.UploadUtil;

@WebServlet("/profile")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,
	    maxFileSize = 10 * 1024 * 1024,
	    maxRequestSize = 20 * 1024 * 1024
	)
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

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

        User user = (User) session.getAttribute("user");

        // Lấy dữ liệu mới nhất từ DB
        User dbUser = userDAO.findById(user.getUsername());

        if (dbUser != null) {
            session.setAttribute("user", dbUser);
            request.setAttribute("user", dbUser);
            user = dbUser;
        } else {
            request.setAttribute("user", user);
        }

        request.setAttribute("backUrl", getDashboardUrl(user, request));

        request.getRequestDispatcher("/user/profile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        User user = userDAO.findById(sessionUser.getUsername());

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        
        Part filePart = request.getPart("avatar");

        if (filePart != null && filePart.getSize() > 0) {

            String uploadPath =
                    UploadUtil.getUploadPath(getServletContext(), "users");

            String fileName =
                    System.currentTimeMillis() + "_"
                    + filePart.getSubmittedFileName();

            filePart.write(uploadPath + File.separator + fileName);

            user.setAvatar(fileName);

        }

        try {

            userDAO.update(user);

            session.setAttribute("user", user);

            request.setAttribute("user", user);
            request.setAttribute("success",
                    "Cập nhật thông tin thành công.");

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("user", user);
            request.setAttribute("error",
                    "Không thể cập nhật thông tin.");

        }

        request.setAttribute("backUrl", getDashboardUrl(user, request));

        request.getRequestDispatcher("/user/profile.jsp")
               .forward(request, response);
    }

    /**
     * Trả về Dashboard theo Role
     */
    private String getDashboardUrl(User user,
                                   HttpServletRequest request) {

        if (user == null || user.getRole() == null) {
            return request.getContextPath() + "/";
        }

        switch (user.getRole().toUpperCase()) {

            case "ADMIN":
                return request.getContextPath() + "/admin/dashboard";

            case "WAITER":
                return request.getContextPath() + "/waiter/dashboard";

            case "CHEF":
                return request.getContextPath() + "/kitchen/dashboard";

            case "CASHIER":
                return request.getContextPath() + "/cashier/dashboard";

            case "STOREKEEPER":
                return request.getContextPath() + "/storekeeper/dashboard";

            default:
                return request.getContextPath() + "/";
        }
    }

}