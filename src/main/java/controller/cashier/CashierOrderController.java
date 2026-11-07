package controller.cashier;

import dao.OrderDAO;
import dao.impl.OrderDAOImpl;
import entity.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/cashier/orders")
public class CashierOrderController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> orders = orderDAO.findWaitingPayment();

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/cashier/orders.jsp")
                .forward(request, response);
    }
}