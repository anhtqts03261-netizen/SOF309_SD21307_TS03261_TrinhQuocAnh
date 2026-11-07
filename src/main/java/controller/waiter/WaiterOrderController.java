package controller.waiter;

import dao.OrderDAO;
import dao.RestaurantTableDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.RestaurantTableDAOImpl;

import entity.Order;
import entity.RestaurantTables;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/waiter/order")
public class WaiterOrderController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer tableId =
                Integer.parseInt(request.getParameter("tableId"));

        // Lấy bàn được chọn
        RestaurantTables table = tableDAO.findById(tableId);

        if (table == null) {
            response.sendRedirect(
                    request.getContextPath() + "/waiter/tables");
            return;
        }

        /*
         * Nếu bàn này là bàn phụ của một nhóm ghép
         * thì lấy bàn chính để thao tác.
         */
        if (table.getMergedWith() != null) {

            table = tableDAO.findById(table.getMergedWith());

        }

        // Tìm Order của bàn chính
        Order order =
                orderDAO.findUnpaidByTable(table.getTableId());

        // Chưa có thì tạo mới
        if (order == null) {

            User waiter =
                    (User) request.getSession()
                            .getAttribute("user");

            order = new Order();

            order.setRestaurantTable(table);
            order.setUser(waiter);
            order.setOrderDate(new Date());
            order.setStatus("UNPAID");
            order.setTotalAmount(0.0);

            orderDAO.insert(order);

            // Chỉ cập nhật bàn chính
            table.setStatus("SERVING");
            tableDAO.update(table);

            System.out.println(
                    "Đã tạo Order mới cho bàn "
                            + table.getTableName());

            order =
                    orderDAO.findUnpaidByTable(
                            table.getTableId());
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/waiter/order-detail?orderId="
                        + order.getOrderId());

    }

}