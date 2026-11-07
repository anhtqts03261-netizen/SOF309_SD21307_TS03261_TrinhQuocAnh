package controller.admin;

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
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/admin/table/add-dish")
public class AddDishController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderDetailDAO detailDAO = new OrderDetailDAOImpl();
    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();
    private DishDAO dishDAO = new DishDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Integer tableId =
                    Integer.parseInt(request.getParameter("tableId"));

            Integer dishId =
                    Integer.parseInt(request.getParameter("dishId"));

            Integer quantity =
                    Integer.parseInt(request.getParameter("quantity"));

            // Lấy user đang đăng nhập
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            // Lấy bàn
            RestaurantTables table = tableDAO.findById(tableId);

            if (table == null) {
                response.sendRedirect(request.getContextPath() + "/admin/table");
                return;
            }

            // Kiểm tra bàn đã có Order chưa
            Order order = orderDAO.findUnpaidByTable(tableId);

            // Nếu chưa có thì tạo mới
            if (order == null) {

                order = new Order();

                order.setRestaurantTable(table);

                order.setUser(user);

                order.setOrderDate(new Date());

                order.setStatus("UNPAID");

                order.setTotalAmount(0.0);

                orderDAO.insert(order);

            }

            // Lấy món
            Dish dish = dishDAO.findById(dishId);

            if (dish == null) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/table/detail?id=" + tableId);
                return;
            }

            // Tạo chi tiết hóa đơn
            OrderDetail detail = new OrderDetail();

            detail.setOrder(order);

            detail.setDish(dish);

            detail.setQuantity(quantity);

            detail.setPrice(dish.getPrice());

            detail.setItemStatus("PENDING");

            detailDAO.insert(detail);
            
            System.out.println("Order ID = " + order.getOrderId());

            // Cập nhật tổng tiền
            orderDAO.updateTotalAmount(order.getOrderId());
            
            System.out.println("Updated total");

            // Đổi trạng thái bàn
            table.setStatus("SERVING");

            tableDAO.update(table);

            // Quay lại trang chi tiết bàn
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/table/detail?id=" + tableId);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(e);

        }

    }

}