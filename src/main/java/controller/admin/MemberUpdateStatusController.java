package controller.admin;

import java.io.IOException;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/member-status")
public class MemberUpdateStatusController extends HttpServlet{

    private CustomerDAO customerDAO =
            new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer id =
                Integer.parseInt(
                        request.getParameter("id"));

        Boolean active =
                Boolean.parseBoolean(
                        request.getParameter("active"));

        customerDAO.updateStatus(id,active);

        response.sendRedirect(
                request.getContextPath()
                        +"/admin/member");

    }

}