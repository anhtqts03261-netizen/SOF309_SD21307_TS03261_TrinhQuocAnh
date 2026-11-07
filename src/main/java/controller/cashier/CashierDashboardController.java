package controller.cashier;

import dao.DashboardDAO;
import dao.impl.DashboardDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/cashier/dashboard")
public class CashierDashboardController extends HttpServlet {

    private DashboardDAO dao = new DashboardDAOImpl();

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

        request.setAttribute(
                "todayRevenue",
                dao.todayRevenue());

        request.setAttribute(
                "unpaidCount",
                dao.countUnpaidOrders());

        request.setAttribute(
                "orders",
                dao.findUnpaidOrders());

        request.getRequestDispatcher(
                "/cashier/dashboard.jsp")
                .forward(request,response);

    }

}