package controller.waiter;

import dao.OrderDAO;
import dao.RestaurantTableDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.RestaurantTableDAOImpl;
import entity.Order;
import entity.RestaurantTables;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/waiter/checkout")
public class WaiterCheckoutController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Integer orderId =
                Integer.parseInt(request.getParameter("orderId"));

        Order order =
                orderDAO.findById(orderId);

        order.setStatus("PAID");

        orderDAO.update(order);

        RestaurantTables table =
                order.getRestaurantTable();

        table.setStatus("EMPTY");

        tableDAO.update(table);

        response.sendRedirect(
                request.getContextPath()
                + "/waiter/tables");
    }
}