package controller.client;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import entity.Customer;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.time.LocalDateTime;

@WebServlet("/client/reservation")
public class ClientReservationController extends HttpServlet {

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("customer") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/client/login");
            return;
        }

        request.getRequestDispatcher("/client/reservation.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("customer") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/client/login");
            return;
        }

        try {

        	LocalDateTime localDateTime =
        	        LocalDateTime.parse(
        	                request.getParameter("reservationTime")
        	        );

        	Timestamp reservationTime =
        	        Timestamp.valueOf(localDateTime);

            Integer guestCount =
                    Integer.valueOf(
                            request.getParameter("guestCount"));

            List<RestaurantTables> tables =
                    tableDAO.findAvailableTables(
                            reservationTime,
                            guestCount);

            request.setAttribute("tables", tables);
            request.setAttribute("guestCount", guestCount);
            request.setAttribute("reservationTime",
                    request.getParameter("reservationTime"));

            request.getRequestDispatcher(
                    "/client/table-select.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Ngày giờ không hợp lệ.");

            request.getRequestDispatcher(
                    "/client/reservation.jsp")
                    .forward(request, response);

        }

    }

}