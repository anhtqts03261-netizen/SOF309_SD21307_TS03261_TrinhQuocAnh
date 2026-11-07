package controller.admin;

import java.io.IOException;
import java.util.List;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;
import entity.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/member")
public class MemberManagementController extends HttpServlet {

    private CustomerDAO customerDAO =
            new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session==null ||
                session.getAttribute("user")==null){

            response.sendRedirect(
                    request.getContextPath()+"/login");

            return;

        }

        String keyword =
                request.getParameter("keyword");

        List<Customer> list;

        if(keyword==null || keyword.isBlank()){

            list = customerDAO.findAll();

        }else{

            list = customerDAO.search(keyword);

        }

        request.setAttribute(
                "memberList",
                list);

        request.getRequestDispatcher(
                "/admin/member.jsp")
                .forward(request,response);

    }

}