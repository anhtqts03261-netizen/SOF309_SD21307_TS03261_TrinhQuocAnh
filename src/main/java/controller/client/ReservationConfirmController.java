package controller.client;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ReservationDAO;
import dao.RestaurantTableDAO;
import dao.impl.CustomerDAOImpl;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import dao.impl.ReservationDAOImpl;
import dao.impl.RestaurantTableDAOImpl;
import entity.Customer;
import entity.Order;
import entity.OrderDetail;
import entity.Reservation;
import entity.RestaurantTables;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;

@WebServlet("/client/reservation-confirm")
public class ReservationConfirmController extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAOImpl();
    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAOImpl();
    private CustomerDAO customerDAO = new CustomerDAOImpl();

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("customer") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/client/login");

            return;

        }

        Customer customer =
                (Customer) session.getAttribute("customer");

        Integer tableId =
                (Integer) session.getAttribute("selectedTable");

        Integer guestCount =
                (Integer) session.getAttribute("guestCount");

        Timestamp reservationTime =
                (Timestamp) session.getAttribute("reservationTime");

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("reservationCart");

        if (tableId == null
                || guestCount == null
                || reservationTime == null
                || cart == null
                || cart.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/client/reservation");

            return;

        }

        RestaurantTables table =
                tableDAO.findById(tableId);

        if (table == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/client/reservation");

            return;

        }

        //------------------------------------------------------
        // Tạo Reservation
        //------------------------------------------------------

        Reservation reservation = new Reservation();

        reservation.setCustomer(customer);

        reservation.setCustomerName(
                customer.getFullName());

        reservation.setPhone(
                customer.getPhone());

        reservation.setRestaurantTable(table);

        reservation.setGuestCount(guestCount);

        reservation.setReservationTime(reservationTime);

        reservation.setDuration(120);

        reservation.setStatus("PENDING");

        reservationDAO.insert(reservation);

        //------------------------------------------------------
        // Tạo Order
        //------------------------------------------------------

        Order order = new Order();

        order.setRestaurantTable(table);

        order.setCustomer(customer);

        // chưa có waiter nhận bàn
        order.setUser(null);

        order.setOrderDate(new Date());

        order.setStatus("RESERVED");

        order.setTotalAmount(0.0);

        order.setReservation(reservation);
        
        orderDAO.insert(order);

      //------------------------------------------------------
     // Tạo OrderDetail
     //------------------------------------------------------

     double total = 0;

     for (CartItem item : cart) {

         OrderDetail detail = new OrderDetail();

         detail.setOrder(order);

         detail.setDish(item.getDish());

         detail.setQuantity(item.getQuantity());

         detail.setPrice(item.getDish().getPrice());

         detail.setNote("");

         detail.setItemStatus("PENDING");

         orderDetailDAO.insert(detail);

         total += item.getTotal();

     }

     //------------------------------------------------------
     // Cập nhật tổng tiền Order
     //------------------------------------------------------

     order.setTotalAmount(total);

     orderDAO.update(order);

     //------------------------------------------------------
     // Không cập nhật totalSpent ở đây
     // Chỉ cập nhật khi Order = PAID
     //------------------------------------------------------

     //------------------------------------------------------
     // Xóa Session tạm
     //------------------------------------------------------

     session.removeAttribute("reservationCart");

     session.removeAttribute("selectedTable");

     session.removeAttribute("guestCount");

     session.removeAttribute("reservationTime");

     //------------------------------------------------------
     // Thông báo thành công
     //------------------------------------------------------

     session.setAttribute(
             "reservationSuccess",
             "Đặt bàn thành công!");

     response.sendRedirect(
             request.getContextPath()
             + "/client/reservation-success");
    }
}
