package controller.admin;

import java.io.IOException;

import dao.StockExportDAO;
import dao.impl.StockExportDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/export-receipt")
public class AdminExportReceiptController extends HttpServlet {

    private StockExportDAO dao =
            new StockExportDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "list",
                dao.findAll());

        request.getRequestDispatcher(
                "/admin/export-receipt.jsp")
                .forward(request, response);
    }
}