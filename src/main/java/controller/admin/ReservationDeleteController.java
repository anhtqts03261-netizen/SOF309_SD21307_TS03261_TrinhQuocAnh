package controller.admin;

import dao.ReservationDAO;
import dao.impl.ReservationDAOImpl;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/reservation-delete")
public class ReservationDeleteController extends HttpServlet{

    private ReservationDAO reservationDAO=
            new ReservationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException{

        Integer id=Integer.parseInt(
                request.getParameter("id"));

        reservationDAO.delete(id);

        response.sendRedirect(
                request.getContextPath()
                +"/admin/reservation");

    }

}