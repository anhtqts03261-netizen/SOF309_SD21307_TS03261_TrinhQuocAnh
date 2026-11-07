package controller.storekeeper;

import dao.InventoryDetailDAO;
import dao.InventoryReceiptDAO;
import dao.IngredientDAO;

import dao.impl.InventoryDetailDAOImpl;
import dao.impl.InventoryReceiptDAOImpl;
import dao.impl.IngredientDAOImpl;

import entity.InventoryDetail;
import entity.InventoryReceipt;
import entity.Ingredient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/storekeeper/receipt/detail")
public class ReceiptDetailController
        extends HttpServlet{

    private InventoryReceiptDAO receiptDAO=
            new InventoryReceiptDAOImpl();

    private InventoryDetailDAO detailDAO=
            new InventoryDetailDAOImpl();

    private IngredientDAO ingredientDAO=
            new IngredientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        Integer receiptId=
                Integer.parseInt(request.getParameter("id"));

        InventoryReceipt receipt=
                receiptDAO.findById(receiptId);

        List<InventoryDetail> details=
                detailDAO.findByReceipt(receiptId);

        List<Ingredient> ingredients=
                ingredientDAO.findAll();

        request.setAttribute("receipt",receipt);

        request.setAttribute("details",details);

        request.setAttribute("ingredients",ingredients);

        request.getRequestDispatcher(
                "/storekeeper/receipt-detail.jsp")
                .forward(request,response);

    }

}