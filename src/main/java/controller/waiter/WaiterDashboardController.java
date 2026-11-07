package controller.waiter;

import java.io.IOException;

import dao.DashboardDAO;
import dao.impl.DashboardDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/waiter/dashboard")
public class WaiterDashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DashboardDAO dashboardDAO =
            new DashboardDAOImpl();

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

        request.setAttribute(
                "availableTables",
                dashboardDAO.countAvailableTables());

        request.setAttribute(
                "occupiedTables",
                dashboardDAO.countOccupiedTables());

        request.setAttribute(
                "reservedTables",
                dashboardDAO.countReservedTables());

        request.setAttribute(
                "unpaidOrders",
                dashboardDAO.countUnpaidOrders());

        request.setAttribute(
                "tableList",
                dashboardDAO.findAllTables());

        request.setAttribute(
                "orderList",
                dashboardDAO.findUnpaidOrders());

        request.getRequestDispatcher(
                "/waiter/dashboard.jsp")
                .forward(request, response);

    }

}