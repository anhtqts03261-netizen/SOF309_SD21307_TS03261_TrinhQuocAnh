package controller.waiter;

import java.io.IOException;

import dao.DishDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ReservationDAO;

import dao.impl.DishDAOImpl;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import dao.impl.ReservationDAOImpl;

import entity.Dish;
import entity.Order;
import entity.OrderDetail;
import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/waiter/reservation-add-dish")
public class ReservationAddDishController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    private OrderDAO orderDAO =
            new OrderDAOImpl();

    private DishDAO dishDAO =
            new DishDAOImpl();

    private OrderDetailDAO orderDetailDAO =
            new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

            return;
        }

        Integer reservationId =
                Integer.parseInt(request.getParameter("reservationId"));

        Integer dishId =
                Integer.parseInt(request.getParameter("dishId"));

        //----------------------------------------
        // Reservation
        //----------------------------------------

        Reservation reservation =
                reservationDAO.findById(reservationId);

        if (reservation == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservations");

            return;

        }

        //----------------------------------------
        // Không cho sửa khi đã nhận khách
        //----------------------------------------

        if ("COMPLETED".equals(reservation.getStatus())) {

            session.setAttribute(
                    "error",
                    "Khách đã nhận bàn, không thể chỉnh sửa món.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservation-detail?id="
                            + reservationId);

            return;

        }

        //----------------------------------------
        // Order
        //----------------------------------------

        Order order =
                orderDAO.findByReservation(reservationId);

        if (order == null) {

            session.setAttribute(
                    "error",
                    "Không tìm thấy Order.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservations");

            return;

        }

        //----------------------------------------
        // Dish
        //----------------------------------------

        Dish dish =
                dishDAO.findById(dishId);

        if (dish == null) {

            session.setAttribute(
                    "error",
                    "Món ăn không tồn tại.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservation-detail?id="
                            + reservationId);

            return;

        }

        if (!dish.getIsActive()) {

            session.setAttribute(
                    "error",
                    "Món ăn hiện đang ngừng phục vụ.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservation-detail?id="
                            + reservationId);

            return;

        }

        //----------------------------------------
        // Kiểm tra OrderDetail
        //----------------------------------------

        OrderDetail detail =
                orderDetailDAO.findByOrderAndDish(
                        order.getOrderId(),
                        dishId);

        if (detail == null) {

            detail = new OrderDetail();

            detail.setOrder(order);

            detail.setDish(dish);

            detail.setQuantity(1);

            detail.setPrice(dish.getPrice());

            detail.setItemStatus("PENDING");

            orderDetailDAO.insert(detail);

        } else {

            detail.setQuantity(
                    detail.getQuantity() + 1);

            orderDetailDAO.update(detail);

        }

        //----------------------------------------
        // Update tổng tiền
        //----------------------------------------

        orderDAO.updateTotalAmount(
                order.getOrderId());

        session.setAttribute(
                "success",
                "Đã thêm món thành công.");

        response.sendRedirect(
                request.getContextPath()
                        + "/waiter/reservation-detail?id="
                        + reservationId);

    }

}