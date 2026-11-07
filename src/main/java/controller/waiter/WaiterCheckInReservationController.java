package controller.waiter;

import java.io.IOException;

import dao.OrderDAO;
import dao.ReservationDAO;
import dao.RestaurantTableDAO;

import dao.impl.OrderDAOImpl;
import dao.impl.ReservationDAOImpl;
import dao.impl.RestaurantTableDAOImpl;

import entity.Order;
import entity.Reservation;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/waiter/checkin-reservation")
public class WaiterCheckInReservationController extends HttpServlet {

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    private OrderDAO orderDAO =
            new OrderDAOImpl();

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

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

        User waiter =
                (User) session.getAttribute("user");

        Integer reservationId =
                Integer.parseInt(request.getParameter("id"));

        Reservation reservation =
                reservationDAO.findById(reservationId);

        if (reservation == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/tables");

            return;

        }

        Order order =
                orderDAO.findByReservation(reservationId);

        if (order == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/waiter/tables");

            return;

        }

        //-----------------------------------
        // Reservation
        //-----------------------------------

        reservationDAO.complete(
                reservationId);

        //-----------------------------------
        // Order
        //-----------------------------------

        orderDAO.assignWaiter(
                order.getOrderId(),
                waiter.getUsername());

        //-----------------------------------
        // Table
        //-----------------------------------

        tableDAO.updateStatus(
                reservation.getRestaurantTable().getTableId(),
                "SERVING");

        response.sendRedirect(
                request.getContextPath()
                        + "/waiter/tables");

    }

}