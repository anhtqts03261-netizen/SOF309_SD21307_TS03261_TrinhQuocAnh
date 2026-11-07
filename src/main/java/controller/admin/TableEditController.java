package controller.admin;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/table/edit")
public class TableEditController extends HttpServlet {

    private RestaurantTableDAO dao =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer id =
                Integer.parseInt(request.getParameter("id"));

        RestaurantTables table =
                dao.findById(id);

        request.setAttribute("table", table);

        request.getRequestDispatcher(
                "/admin/table-edit.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Integer id =
                Integer.parseInt(request.getParameter("tableId"));

        RestaurantTables table =
                dao.findById(id);

        table.setTableName(
                request.getParameter("tableName"));

        table.setCapacity(
                Integer.parseInt(request.getParameter("capacity")));

        table.setPosition(
                request.getParameter("position"));

        table.setStatus(
                request.getParameter("status"));

        table.setIsActive(
                Boolean.parseBoolean(
                        request.getParameter("isActive")));

        dao.update(table);

        response.sendRedirect(
                request.getContextPath()+"/admin/table");

    }

}