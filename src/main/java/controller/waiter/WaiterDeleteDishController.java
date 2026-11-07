package controller.waiter;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import entity.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/waiter/delete-dish")
public class WaiterDeleteDishController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderDetailDAO detailDAO = new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Integer detailId =
                Integer.parseInt(request.getParameter("detailId"));

        OrderDetail detail =
                detailDAO.findById(detailId);

        Integer orderId =
                detail.getOrder().getOrderId();

        detailDAO.delete(detailId);

        orderDAO.updateTotalAmount(orderId);

        response.sendRedirect(
                request.getContextPath()
                + "/waiter/order-detail?orderId="
                + orderId);
    }
}