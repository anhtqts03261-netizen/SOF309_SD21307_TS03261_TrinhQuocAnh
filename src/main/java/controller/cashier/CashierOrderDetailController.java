package controller.cashier;

import dao.OrderDAO;
import dao.impl.OrderDAOImpl;
import entity.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/cashier/order-detail")
public class CashierOrderDetailController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer orderId =
                Integer.parseInt(request.getParameter("orderId"));

        Order order =
                orderDAO.findById(orderId);

        request.setAttribute("order", order);

        request.getRequestDispatcher("/cashier/order-detail.jsp")
                .forward(request, response);
    }
}