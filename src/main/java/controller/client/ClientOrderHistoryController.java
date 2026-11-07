package controller.client;

import dao.OrderDAO;
import dao.impl.OrderDAOImpl;
import entity.Customer;
import entity.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/client/orders")
public class ClientOrderHistoryController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("customer") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/login");
            return;
        }

        Customer customer =
                (Customer) session.getAttribute("customer");

        List<Order> orders =
                orderDAO.findByCustomer(customer.getCustomerId());

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/client/orders.jsp")
               .forward(request, response);
    }
}