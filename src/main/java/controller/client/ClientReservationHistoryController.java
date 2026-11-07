package controller.client;

import dao.ReservationDAO;
import dao.impl.ReservationDAOImpl;
import entity.Customer;
import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/client/reservations")
public class ClientReservationHistoryController extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("customer") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/client/login");
            return;
        }

        Customer customer =
                (Customer) session.getAttribute("customer");

        List<Reservation> list =
                reservationDAO.findByCustomer(customer.getCustomerId());

        request.setAttribute("reservationList", list);

        request.getRequestDispatcher(
                "/client/reservation-history.jsp")
                .forward(request, response);
    }
}