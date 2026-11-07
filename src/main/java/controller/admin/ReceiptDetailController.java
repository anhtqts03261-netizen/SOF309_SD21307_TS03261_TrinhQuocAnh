package controller.admin;

import dao.InventoryReceiptDAO;
import dao.InventoryDetailDAO;

import dao.impl.InventoryReceiptDAOImpl;
import dao.impl.InventoryDetailDAOImpl;

import entity.InventoryReceipt;
import entity.InventoryDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/receipt/detail")
public class ReceiptDetailController extends HttpServlet {

    InventoryReceiptDAO dao =
            new InventoryReceiptDAOImpl();

    InventoryDetailDAO detailDAO =
            new InventoryDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer id =
                Integer.parseInt(request.getParameter("id"));

        InventoryReceipt receipt =
                dao.findById(id);

        List<InventoryDetail> details =
                detailDAO.findByReceiptId(id);

        request.setAttribute("receipt", receipt);

        request.setAttribute("details", details);

        request.getRequestDispatcher("/admin/receipt-detail.jsp")
                .forward(request, response);

    }

}