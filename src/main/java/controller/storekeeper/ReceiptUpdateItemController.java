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

@WebServlet("/storekeeper/receipt/update-item")
public class ReceiptUpdateItemController extends HttpServlet {

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

        Double newQuantity =
                Double.parseDouble(request.getParameter("quantity"));

        Double newPrice =
                Double.parseDouble(request.getParameter("price"));

        InventoryDetail detail =
                detailDAO.findById(detailId);

        InventoryReceipt receipt =
                detail.getInventoryReceipt();

        Ingredient ingredient =
                detail.getIngredient();

        // Lưu giá trị cũ
        Double oldQuantity = detail.getQuantity();
        Double oldPrice = detail.getPrice();

        // Điều chỉnh tồn kho
        ingredient.setQuantity(
                ingredient.getQuantity()
                - oldQuantity
                + newQuantity);

        ingredientDAO.update(ingredient);

        // Điều chỉnh tổng tiền
        Double total =
                receipt.getTotalAmount();

        total -= oldQuantity * oldPrice;
        total += newQuantity * newPrice;

        receipt.setTotalAmount(total);

        receiptDAO.update(receipt);

        detail.setQuantity(newQuantity);
        detail.setPrice(newPrice);

        detailDAO.update(detail);

        response.sendRedirect(
                request.getContextPath()
                + "/storekeeper/receipt/detail?id="
                + receipt.getReceiptId());

    }

}