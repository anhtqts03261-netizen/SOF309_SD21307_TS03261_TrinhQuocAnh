package controller.waiter;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/waiter/unmerge-table")
public class UnmergeTableController extends HttpServlet {

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer tableId=
                Integer.parseInt(request.getParameter("tableId"));

        tableDAO.unmergeTable(tableId);

        response.sendRedirect(
                request.getContextPath()+"/waiter/tables");

    }

}