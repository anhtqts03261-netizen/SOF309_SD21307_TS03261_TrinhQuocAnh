package controller.waiter;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import entity.RestaurantTables;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/waiter/merge-table")
public class MergeTableController extends HttpServlet {

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer tableId =
                Integer.parseInt(request.getParameter("tableId"));

        String target =
                request.getParameter("targetTable");

        if(target==null){

            request.setAttribute("mainTable",tableId);

            List<RestaurantTables> tables=
                    tableDAO.findAll();

            request.setAttribute("tables",tables);

            request.getRequestDispatcher(
                    "/waiter/merge-table.jsp")
                    .forward(request,response);

            return;
        }

        Integer targetId=Integer.parseInt(target);

        tableDAO.mergeTable(tableId,targetId);

        response.sendRedirect(
                request.getContextPath()+"/waiter/tables");

    }

}