package controller.admin;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/table/delete")
public class TableDeleteController extends HttpServlet {

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

        if(table!=null){

            if(table.getStatus().equals("SERVING")){

                response.sendRedirect(
                        request.getContextPath()
                        +"/admin/table?error=serving");

                return;
            }

            dao.delete(id);
        }

        response.sendRedirect(
                request.getContextPath()
                +"/admin/table");
    }

}