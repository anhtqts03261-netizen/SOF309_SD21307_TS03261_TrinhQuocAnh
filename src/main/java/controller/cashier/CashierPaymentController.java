package controller.cashier;

import dao.OrderDAO;
import dao.PaymentDAO;
import dao.RestaurantTableDAO;

import dao.impl.OrderDAOImpl;
import dao.impl.PaymentDAOImpl;
import dao.impl.RestaurantTableDAOImpl;

import entity.Order;
import entity.Payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/cashier/payment")
public class CashierPaymentController extends HttpServlet {

    private OrderDAO orderDAO =
            new OrderDAOImpl();

    private PaymentDAO paymentDAO =
            new PaymentDAOImpl();

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Integer orderId =
                Integer.parseInt(request.getParameter("orderId"));

        String method =
                request.getParameter("method");

        Order order =
                orderDAO.findById(orderId);

        Payment payment =
                new Payment();

        payment.setOrder(order);

        payment.setAmount(order.getTotalAmount());

        payment.setPaymentMethod(method);

        payment.setPaymentDate(new Date());

        payment.setStatus("SUCCESS");

        paymentDAO.insert(payment);

        orderDAO.updateStatus(orderId, "PAID");

        if (order.getRestaurantTable() != null) {

            order.getRestaurantTable().setStatus("EMPTY");

            tableDAO.update(order.getRestaurantTable());

        }

        response.sendRedirect(
                request.getContextPath()
                        + "/cashier/orders");
    }
}