package controller.waiter;

import java.io.IOException;
import java.util.List;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/waiter/tables")
public class WaiterTableController extends HttpServlet {

    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<RestaurantTables> tables = tableDAO.findAll();

        request.setAttribute("tables", tables);

        request.getRequestDispatcher("/waiter/tables.jsp")
               .forward(request, response);
    }

}