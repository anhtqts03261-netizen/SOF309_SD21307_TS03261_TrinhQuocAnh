package controller.waiter;

import dao.DishDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.impl.DishDAOImpl;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;

import entity.Dish;
import entity.Order;
import entity.OrderDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/waiter/add-dish")
public class WaiterAddDishController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private DishDAO dishDAO = new DishDAOImpl();
    private OrderDetailDAO detailDAO = new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        process(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        process(request, response);
    }

    private void process(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer orderId =
                Integer.parseInt(request.getParameter("orderId"));

        Integer dishId =
                Integer.parseInt(request.getParameter("dishId"));

        Integer quantity =
                Integer.parseInt(request.getParameter("quantity"));

        if (quantity == null || quantity < 1) {
            quantity = 1;
        }

        Order order =
                orderDAO.findById(orderId);

        Dish dish =
                dishDAO.findById(dishId);

        OrderDetail detail =
                detailDAO.findByOrderAndDish(orderId, dishId);

        /*
         * Nếu chưa có món -> tạo mới
         * Nếu đã có nhưng vẫn PENDING -> cộng số lượng
         * Nếu đã gửi bếp -> tạo OrderDetail mới
         */

        if (detail == null) {

            OrderDetail newDetail = new OrderDetail();

            newDetail.setOrder(order);
            newDetail.setDish(dish);
            newDetail.setQuantity(quantity);
            newDetail.setPrice(dish.getPrice());
            newDetail.setItemStatus("PENDING");

            detailDAO.insert(newDetail);

        } else if ("PENDING".equals(detail.getItemStatus())) {

            detail.setQuantity(detail.getQuantity() + quantity);

            detailDAO.update(detail);

        } else {

            OrderDetail newDetail = new OrderDetail();

            newDetail.setOrder(order);
            newDetail.setDish(dish);
            newDetail.setQuantity(quantity);
            newDetail.setPrice(dish.getPrice());
            newDetail.setItemStatus("PENDING");

            detailDAO.insert(newDetail);

        }

        orderDAO.updateTotalAmount(orderId);

        response.sendRedirect(
                request.getContextPath()
                        + "/waiter/order-detail?orderId="
                        + orderId);
    }

}