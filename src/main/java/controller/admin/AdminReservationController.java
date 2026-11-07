package controller.admin;

import java.io.IOException;

import dao.ReservationDAO;
import dao.impl.ReservationDAOImpl;
import entity.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/reservation-old")
public class AdminReservationController extends HttpServlet {

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session==null || session.getAttribute("user")==null){

            response.sendRedirect(
                    request.getContextPath()+"/login");

            return;
        }

        String keyword=request.getParameter("keyword");

        if(keyword==null){
            keyword="";
        }

        request.setAttribute(
                "reservationList",
                reservationDAO.search(keyword));

        request.setAttribute("keyword",keyword);

        request.getRequestDispatcher(
                "/admin/reservation.jsp")
                .forward(request,response);

    }

}