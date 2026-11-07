package controller.admin;

import dao.IngredientDAO;
import dao.impl.IngredientDAOImpl;
import entity.Ingredient;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ingredient")
public class IngredientManagementController extends HttpServlet{

    private IngredientDAO ingredientDAO=new IngredientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException,IOException{

        List<Ingredient> list=ingredientDAO.findAll();

        request.setAttribute("ingredients",list);

        request.getRequestDispatcher("/admin/ingredient.jsp")
                .forward(request,response);

    }

}