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

@WebServlet("/storekeeper/receipt/add-item")
public class ReceiptAddItemController extends HttpServlet {

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

        Integer receiptId =
                Integer.parseInt(request.getParameter("receiptId"));

        Integer ingredientId =
                Integer.parseInt(request.getParameter("ingredientId"));

        Double quantity =
                Double.parseDouble(request.getParameter("quantity"));

        Double price =
                Double.parseDouble(request.getParameter("price"));

        InventoryReceipt receipt =
                receiptDAO.findById(receiptId);

        Ingredient ingredient =
                ingredientDAO.findById(ingredientId);

        InventoryDetail detail =
                detailDAO.findByReceiptAndIngredient(
                        receiptId,
                        ingredientId);

        if (detail == null) {

            detail = new InventoryDetail();

            detail.setInventoryReceipt(receipt);

            detail.setIngredient(ingredient);

            detail.setQuantity(quantity);

            detail.setPrice(price);

            detailDAO.insert(detail);

        } else {

            detail.setQuantity(
                    detail.getQuantity() + quantity);

            detail.setPrice(price);

            detailDAO.update(detail);

        }

        /*
         * Cập nhật tồn kho
         */

        ingredient.setQuantity(
                ingredient.getQuantity() + quantity);

        ingredientDAO.update(ingredient);

        /*
         * Cập nhật tổng tiền phiếu nhập
         */

        receipt.setTotalAmount(
                receipt.getTotalAmount()
                        + quantity * price);

        receiptDAO.update(receipt);

        response.sendRedirect(
                request.getContextPath()
                        + "/storekeeper/receipt/detail?id="
                        + receiptId);

    }

}