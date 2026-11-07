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

@WebServlet("/storekeeper/receipt/delete-item")
public class ReceiptDeleteItemController extends HttpServlet {

    private InventoryDetailDAO detailDAO =
            new InventoryDetailDAOImpl();

    private InventoryReceiptDAO receiptDAO =
            new InventoryReceiptDAOImpl();

    private IngredientDAO ingredientDAO =
            new IngredientDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Integer detailId =
                Integer.parseInt(request.getParameter("detailId"));

        InventoryDetail detail =
                detailDAO.findById(detailId);

        InventoryReceipt receipt =
                detail.getInventoryReceipt();

        Ingredient ingredient =
                detail.getIngredient();

        Double amount =
                detail.getQuantity() * detail.getPrice();

        // Trừ tồn kho
        ingredient.setQuantity(
                ingredient.getQuantity() - detail.getQuantity());

        ingredientDAO.update(ingredient);

        // Trừ tổng tiền phiếu
        receipt.setTotalAmount(
                receipt.getTotalAmount() - amount);

        receiptDAO.update(receipt);

        Integer receiptId = receipt.getReceiptId();

        detailDAO.delete(detailId);

        response.sendRedirect(
                request.getContextPath()
                + "/storekeeper/receipt/detail?id="
                + receiptId);

    }

}