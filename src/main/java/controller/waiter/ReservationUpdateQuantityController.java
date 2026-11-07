package controller.waiter;

import java.io.IOException;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ReservationDAO;

import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import dao.impl.ReservationDAOImpl;

import entity.Order;
import entity.OrderDetail;
import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/waiter/reservation-update-quantity")
public class ReservationUpdateQuantityController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    private OrderDAO orderDAO =
            new OrderDAOImpl();

    private OrderDetailDAO orderDetailDAO =
            new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        Integer reservationId =
                Integer.parseInt(request.getParameter("reservationId"));

        Integer detailId =
                Integer.parseInt(request.getParameter("detailId"));

        String action =
                request.getParameter("action");

        //---------------------------------------
        // Reservation
        //---------------------------------------

        Reservation reservation =
                reservationDAO.findById(reservationId);

        if (reservation == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservations");

            return;
        }

        //---------------------------------------
        // Không cho sửa nếu đã check-in
        //---------------------------------------

        if ("COMPLETED".equals(reservation.getStatus())) {

            session.setAttribute(
                    "error",
                    "Khách đã nhận bàn.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservation-detail?id="
                            + reservationId);

            return;
        }

        //---------------------------------------
        // Order
        //---------------------------------------

        Order order =
                orderDAO.findByReservation(reservationId);

        if (order == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservations");

            return;
        }

        //---------------------------------------
        // Detail
        //---------------------------------------

        OrderDetail detail =
                orderDetailDAO.findById(detailId);

        if (detail == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/reservation-detail?id="
                            + reservationId);

            return;
        }

        //---------------------------------------
        // Tăng số lượng
        //---------------------------------------

        if ("plus".equals(action)) {

            detail.setQuantity(
                    detail.getQuantity() + 1);

            orderDetailDAO.update(detail);

        }

        //---------------------------------------
        // Giảm số lượng
        //---------------------------------------

        else if ("minus".equals(action)) {

            if (detail.getQuantity() > 1) {

                detail.setQuantity(
                        detail.getQuantity() - 1);

                orderDetailDAO.update(detail);

            } else {

                orderDetailDAO.delete(
                        detail.getOrderDetailId());

            }

        }

        //---------------------------------------
        // Update Total
        //---------------------------------------

        orderDAO.updateTotalAmount(
                order.getOrderId());

        response.sendRedirect(
                request.getContextPath()
                        + "/waiter/reservation-detail?id="
                        + reservationId);

    }

}