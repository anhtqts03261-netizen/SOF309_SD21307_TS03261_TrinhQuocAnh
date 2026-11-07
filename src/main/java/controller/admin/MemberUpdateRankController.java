package controller.admin;

import java.io.IOException;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/member-rank")
public class MemberUpdateRankController extends HttpServlet{

    private CustomerDAO customerDAO =
            new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer id =
                Integer.parseInt(
                        request.getParameter("id"));

        String rank =
                request.getParameter("rank");

        customerDAO.updateRank(id,rank);

        response.sendRedirect(
                request.getContextPath()
                        +"/admin/member");

    }

}