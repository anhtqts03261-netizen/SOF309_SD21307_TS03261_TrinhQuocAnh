package controller.admin;

import dao.StockExportDAO;
import dao.impl.StockExportDAOImpl;
import entity.StockExport;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/stock-export")
public class AdminStockExportController extends HttpServlet{

    private StockExportDAO dao =
            new StockExportDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException,IOException{

        List<StockExport> list =
                dao.findAll();

        request.setAttribute("list", list);

        request.getRequestDispatcher(
                "/admin/stock-export.jsp")
                .forward(request,response);

    }

}