package controller.admin;

import java.io.IOException;
import java.util.List;

import dao.ReservationDAO;
import dao.impl.ReservationDAOImpl;
import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/reservation-test")
public class ReservationController extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
                    request.getContextPath() + "/login");

            return;
        }

        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");

        if (keyword == null) {
            keyword = "";
        }

        List<Reservation> list;

        if (keyword.trim().isEmpty()) {

            list = reservationDAO.findAll();

        } else {

            list = reservationDAO.search(keyword);

        }

        if (status != null &&
                !status.isBlank()) {

            list.removeIf(r ->
                    !status.equalsIgnoreCase(r.getStatus()));

        }

        request.setAttribute(
                "reservationList",
                list);

        request.setAttribute(
                "keyword",
                keyword);

        request.setAttribute(
                "status",
                status);

        request.getRequestDispatcher(
                "/admin/reservation.jsp")
                .forward(request, response);

    }

}