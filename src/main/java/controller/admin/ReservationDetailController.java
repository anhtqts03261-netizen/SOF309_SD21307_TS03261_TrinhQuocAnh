package controller.admin;

import java.io.IOException;

import dao.OrderDAO;
import dao.ReservationDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.ReservationDAOImpl;
import entity.Order;
import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/reservation-detail")
public class ReservationDetailController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

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
                Integer.parseInt(
                        request.getParameter("id"));

        Reservation reservation =
                reservationDAO.findById(reservationId);

        if (reservation == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/reservation");

            return;
        }

        Order order =
                orderDAO.findByReservation(
                        reservationId);

        request.setAttribute(
                "reservation",
                reservation);

        request.setAttribute(
                "order",
                order);

        request.getRequestDispatcher(
                "/admin/reservation-detail.jsp")
                .forward(request, response);

    }

}