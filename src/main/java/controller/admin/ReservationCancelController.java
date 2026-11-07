package controller.admin;

import java.io.IOException;

import dao.OrderDAO;
import dao.ReservationDAO;
import dao.RestaurantTableDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.ReservationDAOImpl;
import dao.impl.RestaurantTableDAOImpl;

import entity.Order;
import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/reservation-cancel")
public class ReservationCancelController extends HttpServlet {

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    private OrderDAO orderDAO =
            new OrderDAOImpl();

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
                Integer.parseInt(request.getParameter("id"));

        Reservation reservation =
                reservationDAO.findById(reservationId);

        if (reservation == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/reservations");

            return;

        }

        //------------------------------------------------
        // Hủy Reservation
        //------------------------------------------------

        reservationDAO.cancel(reservationId);

        //------------------------------------------------
        // Trả bàn về EMPTY
        //------------------------------------------------

        if (reservation.getRestaurantTable() != null) {

            tableDAO.updateStatus(
                    reservation.getRestaurantTable().getTableId(),
                    "EMPTY");

        }

        //------------------------------------------------
        // Hủy Order nếu có
        //------------------------------------------------

        if (reservation.getCustomer() != null) {

        	Order order =
        	        orderDAO.findByReservation(
        	                reservationId);

        	if (order != null &&
        		    "RESERVED".equals(order.getStatus())) {

        		    orderDAO.updateStatus(
        		            order.getOrderId(),
        		            "CANCELLED");
        		}

        }

        response.sendRedirect(
                request.getContextPath()
                + "/admin/reservations");

    }

}