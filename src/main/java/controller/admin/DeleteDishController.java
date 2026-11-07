package controller.admin;

import dao.DishDAO;
import dao.impl.DishDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/delete-dish")
public class DeleteDishController extends HttpServlet {

    private DishDAO dishDAO = new DishDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer id =
                Integer.parseInt(request.getParameter("id"));

        dishDAO.delete(id);

        response.sendRedirect(
                request.getContextPath()+"/admin/menu");

    }

}