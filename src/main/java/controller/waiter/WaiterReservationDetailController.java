package controller.waiter;

import java.io.IOException;

import dao.OrderDAO;
import dao.ReservationDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.ReservationDAOImpl;
import dao.DishDAO;
import dao.impl.DishDAOImpl;
import entity.Order;
import entity.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/waiter/reservation-detail")
public class WaiterReservationDetailController extends HttpServlet {

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    private OrderDAO orderDAO =
            new OrderDAOImpl();

    private DishDAO dishDAO =
            new DishDAOImpl();

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
                            + "/waiter/reservations");

            return;
        }

        Order order =
                orderDAO.findByReservation(reservationId);

        request.setAttribute("reservation", reservation);
        request.setAttribute("order", order);
        request.setAttribute("menuList", dishDAO.findAvailable());


        request.getRequestDispatcher(
                "/waiter/reservation-detail.jsp")
                .forward(request, response);

    }

}