package controller.admin;

import java.io.IOException;
import java.util.List;

import entity.InventoryDetail;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/receipt/deleteItem")
public class ReceiptDeleteItemController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        int index =
                Integer.parseInt(request.getParameter("index"));

        HttpSession session =
                request.getSession();

        List<InventoryDetail> cart =
                (List<InventoryDetail>) session.getAttribute("receiptCart");

        if(cart != null &&
           index >= 0 &&
           index < cart.size()){

            cart.remove(index);

            session.setAttribute("receiptCart", cart);
        }

        response.sendRedirect(
                request.getContextPath()+"/admin/receipt/add");
    }

}