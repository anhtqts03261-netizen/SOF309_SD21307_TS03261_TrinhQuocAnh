package controller.storekeeper;

import dao.InventoryReceiptDAO;
import dao.impl.InventoryReceiptDAOImpl;

import entity.InventoryReceipt;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/storekeeper/receipt/add")
public class ReceiptAddController extends HttpServlet{

    private InventoryReceiptDAO dao =
            new InventoryReceiptDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/storekeeper/receipt-add.jsp")
                .forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User user =
                (User)request.getSession()
                .getAttribute("user");

        InventoryReceipt receipt =
                new InventoryReceipt();

        receipt.setReceiptDate(new Date());

        receipt.setUser(user);

        receipt.setType(
                request.getParameter("type"));

        receipt.setTotalAmount(0.0);

        dao.insert(receipt);

        response.sendRedirect(
                request.getContextPath()
                + "/storekeeper/receipt");

    }

}