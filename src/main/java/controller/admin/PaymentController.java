package controller.admin;

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

@WebServlet("/admin/payment")
public class PaymentController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO = new OrderDAOImpl();

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Integer orderId =
                    Integer.parseInt(request.getParameter("orderId"));

            Order order = orderDAO.findById(orderId);

            if (order == null) {

                response.sendRedirect(
                        request.getContextPath() + "/admin/table");

                return;

            }

            // Cập nhật tổng tiền mới nhất
            orderDAO.updateTotalAmount(orderId);

            // Load lại Order sau khi cập nhật
            order = orderDAO.findById(orderId);

            // Thanh toán
            order.setStatus("PAID");

            orderDAO.update(order);

            // Cập nhật trạng thái bàn
            RestaurantTables table =
                    order.getRestaurantTable();

            table.setStatus("EMPTY");

            tableDAO.update(table);

            response.sendRedirect(
                    request.getContextPath() + "/admin/table");

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(e);

        }

    }

}