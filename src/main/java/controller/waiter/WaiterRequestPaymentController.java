package controller.waiter;

import java.io.IOException;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/waiter/request-payment")
public class WaiterRequestPaymentController extends HttpServlet {

    private OrderDAO orderDAO =
            new OrderDAOImpl();
    private OrderDetailDAO detailDAO =
            new OrderDetailDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Integer orderId =
                Integer.parseInt(
                        request.getParameter("orderId"));

        Order order =
                orderDAO.findById(orderId);

        if(order != null){

        	if(detailDAO.allCompleted(orderId)){

        	    order.setStatus("WAITING_PAYMENT");

        	    orderDAO.update(order);

        	}

            orderDAO.update(order);

        }

        response.sendRedirect(
                request.getContextPath()
                + "/waiter/order-detail?orderId="
                + orderId);

    }

}