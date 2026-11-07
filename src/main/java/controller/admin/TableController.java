package controller.admin;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;

import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/table")
public class TableController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantTableDAO dao =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<RestaurantTables> tables = dao.findAll();

        request.setAttribute("tables", tables);

        request.setAttribute("totalTable",
                dao.countAll());

        request.setAttribute("available",
                dao.countEmpty());

        request.setAttribute("occupied",
                dao.countServing());

        request.setAttribute("reserved",
                dao.countReserved());

        request.getRequestDispatcher("/admin/table.jsp")
                .forward(request, response);

    }

}