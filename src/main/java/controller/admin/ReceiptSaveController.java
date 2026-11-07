package controller.admin;

import dao.*;
import dao.impl.*;

import entity.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/receipt/save")
public class ReceiptSaveController extends HttpServlet {

    private InventoryReceiptDAO receiptDAO =
            new InventoryReceiptDAOImpl();

    private InventoryDetailDAO detailDAO =
            new InventoryDetailDAOImpl();

    private IngredientDAO ingredientDAO =
            new IngredientDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<InventoryDetail> cart =
                (List<InventoryDetail>) session.getAttribute("receiptCart");

        if (cart == null || cart.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/receipt/add");

            return;
        }

        User user = (User) session.getAttribute("user");

        InventoryReceipt receipt = new InventoryReceipt();
        
        receipt.setType("IMPORT");

        receipt.setReceiptDate(new Date());

        receipt.setUser(user);

        double total = 0;

        for (InventoryDetail d : cart) {

            total += d.getQuantity() * d.getPrice();
        }

        receipt.setTotalAmount(total);

        receiptDAO.save(receipt);

        for (InventoryDetail d : cart) {

            d.setInventoryReceipt(receipt);

            detailDAO.save(d);

            Ingredient ingredient =
                    d.getIngredient();

            ingredient.setQuantity(
                    ingredient.getQuantity() + d.getQuantity());

            ingredientDAO.update(ingredient);

        }

        session.removeAttribute("receiptCart");

        response.sendRedirect(
                request.getContextPath() + "/admin/inventory");

    }

}