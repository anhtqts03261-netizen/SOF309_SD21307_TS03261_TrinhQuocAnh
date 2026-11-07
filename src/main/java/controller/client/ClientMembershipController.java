package controller.client;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;
import entity.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/client/membership")
public class ClientMembershipController extends HttpServlet {

    private CustomerDAO customerDAO =
            new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session==null ||
           session.getAttribute("customer")==null){

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/login");

            return;
        }

        Customer customer =
                (Customer) session.getAttribute("customer");

        customer =
                customerDAO.findById(customer.getCustomerId());

        request.setAttribute("customer", customer);

        request.getRequestDispatcher(
                "/client/membership.jsp")
                .forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session==null ||
           session.getAttribute("customer")==null){

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/login");

            return;
        }

        Customer customer =
                (Customer) session.getAttribute("customer");

        customer =
                customerDAO.findById(customer.getCustomerId());

        customer.setIsMember(true);

        if(customer.getRank()==null){

            customer.setRank("BRONZE");

        }

        customerDAO.update(customer);

        session.setAttribute("customer", customer);

        response.sendRedirect(
                request.getContextPath()
                + "/client/membership");

    }

}