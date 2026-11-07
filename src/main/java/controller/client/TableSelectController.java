package controller.client;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/client/select-table")
public class TableSelectController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {

            Integer tableId =
                    Integer.parseInt(
                            request.getParameter("tableId"));

            Integer guestCount =
                    Integer.parseInt(
                            request.getParameter("guestCount"));

            LocalDateTime dateTime =
                    LocalDateTime.parse(
                            request.getParameter("reservationTime"));

            Timestamp reservationTime =
                    Timestamp.valueOf(dateTime);

            session.setAttribute(
                    "selectedTable",
                    tableId);

            session.setAttribute(
                    "guestCount",
                    guestCount);

            session.setAttribute(
                    "reservationTime",
                    reservationTime);

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/reservation-menu");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/reservation");

        }

    }

}