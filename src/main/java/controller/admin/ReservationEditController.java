package controller.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;

import dao.ReservationDAO;
import dao.RestaurantTableDAO;
import dao.impl.ReservationDAOImpl;
import dao.impl.RestaurantTableDAOImpl;
import entity.Reservation;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/reservation-edit")
public class ReservationEditController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

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

        Integer id =
                Integer.parseInt(
                        request.getParameter("id"));

        Reservation reservation =
                reservationDAO.findById(id);

        if (reservation == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/reservation");

            return;
        }

        request.setAttribute(
                "reservation",
                reservation);

        request.setAttribute(
                "tableList",
                tableDAO.findAll());

        request.getRequestDispatcher(
                "/admin/reservation-edit.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Integer id =
                Integer.parseInt(
                        request.getParameter("id"));

        Reservation reservation =
                reservationDAO.findById(id);

        if (reservation == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/reservation");

            return;
        }

        reservation.setCustomerName(
                request.getParameter("customerName"));

        reservation.setPhone(
                request.getParameter("phone"));

        reservation.setGuestCount(
                Integer.parseInt(
                        request.getParameter("guestCount")));

        reservation.setDuration(
                Integer.parseInt(
                        request.getParameter("duration")));

        reservation.setStatus(
                request.getParameter("status"));

        try {

            reservation.setReservationTime(

                    new SimpleDateFormat(
                            "yyyy-MM-dd'T'HH:mm")

                            .parse(
                                    request.getParameter(
                                            "reservationTime"))

            );

        } catch (Exception e) {

            e.printStackTrace();

        }

        Integer tableId =
                Integer.parseInt(
                        request.getParameter("tableId"));

        RestaurantTables table =
                tableDAO.findById(tableId);

        reservation.setRestaurantTable(table);

        reservationDAO.update(reservation);

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/reservation-detail?id="
                        + id);

    }

}