package controller.admin;

import dao.InventoryReceiptDAO;
import dao.impl.InventoryReceiptDAOImpl;
import entity.InventoryReceipt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/receipt/history")
public class ReceiptHistoryController extends HttpServlet {

    private InventoryReceiptDAO dao =
            new InventoryReceiptDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<InventoryReceipt> receipts =
                dao.findAll();

        request.setAttribute("receipts", receipts);

        request.getRequestDispatcher(
                "/admin/receipt-history.jsp")
                .forward(request, response);

    }

}