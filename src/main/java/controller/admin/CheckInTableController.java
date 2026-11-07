package controller.admin;

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

@WebServlet("/admin/table/checkin")
public class CheckInTableController extends HttpServlet {

    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer tableId = Integer.parseInt(request.getParameter("id"));

        RestaurantTables table = tableDAO.findById(tableId);

        if (table == null) {
            response.sendRedirect(request.getContextPath() + "/admin/table");
            return;
        }

        // Kiểm tra bàn đã có Order chưa thanh toán chưa
        Order order = orderDAO.findUnpaidByTable(tableId);

        if (order == null) {

            HttpSession session = request.getSession();

            User user = (User) session.getAttribute("user");

            order = new Order();

            order.setRestaurantTable(table);
            order.setUser(user);
            order.setOrderDate(new Date());
            order.setStatus("UNPAID");
            order.setTotalAmount(0.0);

            orderDAO.insert(order);

            table.setStatus("SERVING");
            tableDAO.update(table);

            // Lấy lại Order vừa tạo
            order = orderDAO.findUnpaidByTable(tableId);
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/order/detail?id="
                        + order.getOrderId());

    }
}