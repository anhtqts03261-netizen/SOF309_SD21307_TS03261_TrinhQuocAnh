package controller.admin;

import dao.IngredientDAO;
import dao.impl.IngredientDAOImpl;
import entity.Ingredient;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/inventory")
public class InventoryController extends HttpServlet{

    IngredientDAO dao=new IngredientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException,IOException{

        List<Ingredient> list=dao.findAll();

        request.setAttribute("ingredients",list);

        request.setAttribute(
                "totalIngredient",
                dao.countIngredient());

        request.setAttribute(
                "lowStock",
                dao.countLowStock());

        request.setAttribute(
                "outStock",
                dao.countOutOfStock());

        request.getRequestDispatcher(
                "/admin/inventory.jsp")
                .forward(request,response);

    }

}