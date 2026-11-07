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
import jakarta.servlet.http.*;

@WebServlet("/admin/order-detail")
public class AdminOrderDetailController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderDetailDAO detailDAO = new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = Integer.valueOf(request.getParameter("id"));

        Order order = orderDAO.findById(id);

        if(order == null){

            response.sendRedirect(
                request.getContextPath()+"/admin/customers");

            return;
        }

        List<OrderDetail> details =
                detailDAO.findByOrderId(id);

        request.setAttribute("order", order);

        request.setAttribute("details", details);

        request.getRequestDispatcher(
                "/admin/order-detail.jsp")
                .forward(request, response);

    }

}