package controller.storekeeper;

import dao.IngredientDAO;
import dao.impl.IngredientDAOImpl;
import entity.Ingredient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/storekeeper/inventory")
public class InventoryController extends HttpServlet {

    private IngredientDAO dao =
            new IngredientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Ingredient> list =
                dao.findAll();

        request.setAttribute("ingredients", list);

        request.getRequestDispatcher(
                "/storekeeper/inventory.jsp")
                .forward(request, response);

    }

}