package controller.admin;

import java.io.IOException;

import dao.ReservationDAO;
import dao.RestaurantTableDAO;
import dao.impl.ReservationDAOImpl;
import dao.impl.RestaurantTableDAOImpl;
import entity.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/reservation-confirm")
public class ReservationConfirmController extends HttpServlet {

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

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

        // Nếu đã xác nhận thì không xác nhận lại
        if ("CONFIRMED".equals(reservation.getStatus())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/reservation");

            return;

        }

        // Nếu đã hủy thì không xác nhận
        if ("CANCELLED".equals(reservation.getStatus())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/reservation");

            return;

        }

        // Cập nhật trạng thái Reservation
        reservationDAO.confirm(reservationId);

        // Đổi trạng thái bàn
        if (reservation.getRestaurantTable() != null) {

            tableDAO.updateStatus(
                    reservation.getRestaurantTable().getTableId(),
                    "RESERVED");

        }

        response.sendRedirect(
                request.getContextPath()
                + "/admin/reservation");

    }

}