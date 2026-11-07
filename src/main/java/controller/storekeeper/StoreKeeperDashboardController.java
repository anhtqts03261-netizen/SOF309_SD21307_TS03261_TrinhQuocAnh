package controller.storekeeper;

import dao.IngredientDAO;
import dao.InventoryReceiptDAO;
import dao.StockExportDAO;

import dao.impl.IngredientDAOImpl;
import dao.impl.InventoryReceiptDAOImpl;
import dao.impl.StockExportDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/storekeeper/dashboard")
public class StoreKeeperDashboardController
        extends HttpServlet{

    private IngredientDAO ingredientDAO =
            new IngredientDAOImpl();

    private InventoryReceiptDAO receiptDAO =
            new InventoryReceiptDAOImpl();

    private StockExportDAO exportDAO =
            new StockExportDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "totalIngredient",
                ingredientDAO.countAll());

        request.setAttribute(
                "lowStock",
                ingredientDAO.countLowStock());

        request.setAttribute(
                "totalReceipt",
                receiptDAO.countAll());

        request.setAttribute(
                "totalExport",
                exportDAO.countAll());

        request.getRequestDispatcher(
                "/storekeeper/dashboard.jsp")
                .forward(request,response);
        
        request.setAttribute(
                "lowStockList",
                ingredientDAO.findLowStock());

        request.setAttribute(
                "lowStockCount",
                ingredientDAO.countLowStock());

    }

}