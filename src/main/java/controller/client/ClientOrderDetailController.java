package controller.client;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;

import entity.Customer;
import entity.Order;
import entity.OrderDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/client/order-detail")
public class ClientOrderDetailController extends HttpServlet {

    private OrderDAO orderDAO =
            new OrderDAOImpl();

    private OrderDetailDAO detailDAO =
            new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session == null ||
           session.getAttribute("customer")==null){

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/login");

            return;
        }

        Integer orderId =
                Integer.parseInt(
                        request.getParameter("orderId"));

        Order order =
                orderDAO.findById(orderId);

        Customer customer =
                (Customer) session.getAttribute("customer");

        if(order == null ||
           order.getCustomer()==null ||
           !order.getCustomer().getCustomerId()
                 .equals(customer.getCustomerId())){

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/orders");

            return;
        }

        List<OrderDetail> details =
                detailDAO.findByOrderId(orderId);

        request.setAttribute("order", order);
        request.setAttribute("details", details);

        request.getRequestDispatcher(
                "/client/order-detail.jsp")
                .forward(request,response);

    }

}