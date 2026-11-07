package controller.waiter;

import dao.OrderDetailDAO;
import dao.impl.OrderDetailDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/waiter/serve")
public class WaiterServeController extends HttpServlet {

    private OrderDetailDAO dao =
            new OrderDetailDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Integer detailId =
                Integer.parseInt(request.getParameter("detailId"));

        Integer orderId =
                Integer.parseInt(request.getParameter("orderId"));

        dao.updateStatus(detailId, "SERVED");

        response.sendRedirect(
                request.getContextPath()
                + "/waiter/order-detail?orderId="
                + orderId);

    }

}