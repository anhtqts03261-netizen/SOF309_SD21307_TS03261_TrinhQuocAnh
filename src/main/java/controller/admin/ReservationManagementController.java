package controller.admin;

import dao.ReservationDAO;
import dao.impl.ReservationDAOImpl;
import entity.Reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reservation")
public class ReservationManagementController extends HttpServlet {

    private ReservationDAO reservationDAO =
            new ReservationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session==null ||
           session.getAttribute("user")==null){

            response.sendRedirect(
                    request.getContextPath()+"/login");

            return;
        }

        String keyword=request.getParameter("keyword");
        String status=request.getParameter("status");

        List<Reservation> list;

        if(keyword!=null && !keyword.isBlank()){

            list=reservationDAO.search(keyword);

        }else{

            list=reservationDAO.findAll();

        }

        if(status!=null &&
                !status.isBlank()){

            list.removeIf(r->
                    !status.equals(r.getStatus()));
        }

        request.setAttribute("reservationList",list);

        request.getRequestDispatcher(
                "/admin/reservation.jsp")
                .forward(request,response);

    }

}