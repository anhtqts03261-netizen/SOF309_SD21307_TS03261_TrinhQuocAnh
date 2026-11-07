package controller.admin;

import java.io.IOException;
import java.util.List;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import entity.Order;
import entity.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/customer-order")
public class CustomerOrderController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        Integer orderId = Integer.valueOf(idParam);

        Order order = orderDAO.findById(orderId);

        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        List<OrderDetail> details =
                orderDetailDAO.findByOrderId(orderId);

        request.setAttribute("order", order);
        request.setAttribute("details", details);

        request.getRequestDispatcher("/admin/customer-order.jsp")
                .forward(request, response);

    }

}