package controller.waiter;

import dao.DishDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.RestaurantTableDAO;
import dao.impl.DishDAOImpl;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import dao.impl.RestaurantTableDAOImpl;
import entity.Dish;
import entity.Order;
import entity.OrderDetail;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/waiter/order-detail")
public class WaiterOrderDetailController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderDetailDAO detailDAO = new OrderDetailDAOImpl();
    private DishDAO dishDAO = new DishDAOImpl();
    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer orderId =
                Integer.parseInt(request.getParameter("orderId"));

        Order order = orderDAO.findById(orderId);

        if (order == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/tables");

            return;
        }

        /*
         * Nếu Order thuộc bàn phụ
         * thì chuyển sang Order của bàn chính.
         */
        RestaurantTables table =
                order.getRestaurantTable();

        if (table.getMergedWith() != null) {

            Order masterOrder =
                    orderDAO.findUnpaidByTable(
                            table.getMergedWith());

            if (masterOrder != null) {

                order = masterOrder;
                orderId = masterOrder.getOrderId();

            }

        }

        List<OrderDetail> details =
                detailDAO.findByOrderId(orderId);

        List<Dish> dishes =
                dishDAO.findAll();

        request.setAttribute("order", order);
        request.setAttribute("details", details);
        request.setAttribute("dishes", dishes);

        request.getRequestDispatcher(
                "/waiter/order-detail.jsp")
                .forward(request, response);

    }

}