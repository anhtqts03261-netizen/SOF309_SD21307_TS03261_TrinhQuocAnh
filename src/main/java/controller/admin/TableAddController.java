package controller.admin;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/table/add")
public class TableAddController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantTableDAO dao =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/admin/table-add.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        RestaurantTables table = new RestaurantTables();

        table.setTableName(
                request.getParameter("tableName"));

        table.setCapacity(
                Integer.parseInt(request.getParameter("capacity")));

        table.setStatus(
                request.getParameter("status"));

        dao.insert(table);

        response.sendRedirect(
                request.getContextPath() + "/admin/table");

    }

}