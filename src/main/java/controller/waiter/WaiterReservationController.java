package controller.waiter;

import java.io.IOException;
import java.util.List;

import dao.ReservationDAO;
import dao.impl.ReservationDAOImpl;

import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/waiter/reservations")
public class WaiterReservationController extends HttpServlet {

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath()+"/login");

            return;
        }

        List<Reservation> reservations =
                reservationDAO.findTodayConfirmedReservations();

        request.setAttribute(
                "reservations",
                reservations);

        request.getRequestDispatcher(
                "/waiter/reservations.jsp")
                .forward(request,response);

    }

}