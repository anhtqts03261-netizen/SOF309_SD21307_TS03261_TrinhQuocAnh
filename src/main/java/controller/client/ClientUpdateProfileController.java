package controller.client;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;
import entity.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/client/update-profile")
public class ClientUpdateProfileController extends HttpServlet {

    private CustomerDAO customerDAO =
            new CustomerDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("customer") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/client/login");

            return;
        }

        Customer loginCustomer =
                (Customer) session.getAttribute("customer");

        Customer customer =
                customerDAO.findById(loginCustomer.getCustomerId());

        customer.setFullName(
                request.getParameter("fullName"));

        customer.setPhone(
                request.getParameter("phone"));

        customer.setEmail(
                request.getParameter("email"));

        String password =
                request.getParameter("password");

        if (password != null && !password.isBlank()) {

            customer.setPassword(password);

        }

        customerDAO.update(customer);

        session.setAttribute("customer", customer);

        response.sendRedirect(
                request.getContextPath()
                        + "/client/profile");
    }

}