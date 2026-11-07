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

@WebServlet("/waiter/update-quantity")
public class WaiterUpdateQuantityController extends HttpServlet {

    private OrderDetailDAO detailDAO = new OrderDetailDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Integer detailId =
                Integer.parseInt(request.getParameter("detailId"));

        String action =
                request.getParameter("action");

        OrderDetail detail =
                detailDAO.findById(detailId);

        Integer orderId =
                detail.getOrder().getOrderId();

        if ("plus".equals(action)) {

            detail.setQuantity(detail.getQuantity() + 1);

            detailDAO.update(detail);

        } else {

            if (detail.getQuantity() > 1) {

                detail.setQuantity(detail.getQuantity() - 1);

                detailDAO.update(detail);

            } else {

                detailDAO.delete(detailId);

            }

        }

        orderDAO.updateTotalAmount(orderId);

        response.sendRedirect(
                request.getContextPath()
                + "/waiter/order-detail?orderId="
                + orderId);
    }
}