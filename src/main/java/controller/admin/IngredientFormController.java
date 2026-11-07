package controller.admin;

import dao.IngredientDAO;
import dao.impl.IngredientDAOImpl;
import entity.Ingredient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/ingredient/*")
public class IngredientFormController extends HttpServlet {

    private IngredientDAO dao = new IngredientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || path.equals("/add")) {

            request.setAttribute("ingredient", new Ingredient());

            request.getRequestDispatcher("/admin/ingredient-form.jsp")
                    .forward(request, response);

            return;
        }

        if (path.equals("/edit")) {

            Integer id =
                    Integer.parseInt(request.getParameter("id"));

            Ingredient ingredient = dao.findById(id);

            request.setAttribute("ingredient", ingredient);

            request.getRequestDispatcher("/admin/ingredient-form.jsp")
                    .forward(request, response);

            return;
        }

        if (path.equals("/delete")) {

            Integer id =
                    Integer.parseInt(request.getParameter("id"));

            dao.delete(id);

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/inventory");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("ingredientId");

        Ingredient ingredient = new Ingredient();

        if (id != null && !id.isEmpty()) {
            ingredient.setIngredientId(Integer.parseInt(id));
        }

        ingredient.setIngredientName(
                request.getParameter("ingredientName"));

        ingredient.setQuantity(
                Double.parseDouble(
                        request.getParameter("quantity")));

        ingredient.setUnit(
                request.getParameter("unit"));

        ingredient.setMinQuantity(
                Double.parseDouble(
                        request.getParameter("minQuantity")));

        if (ingredient.getIngredientId() == null) {

            dao.insert(ingredient);

        } else {

            dao.update(ingredient);

        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/inventory");

    }

}