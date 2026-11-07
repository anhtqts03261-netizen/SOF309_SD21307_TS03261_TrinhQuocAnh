package controller.admin;

import dao.OrderDAO;
import dao.impl.OrderDAOImpl;
import dao.IngredientDAO;
import dao.impl.IngredientDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/report")
public class ReportController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAOImpl();
    private IngredientDAO ingredientDAO = new IngredientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Double total = orderDAO.getTotalRevenue();

            request.setAttribute("totalRevenue", total != null ? total : 0);
            request.setAttribute("totalOrders", orderDAO.countOrders());
            request.setAttribute("lowStockCount", ingredientDAO.countLowStock());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("totalRevenue", 0);
            request.setAttribute("totalOrders", 0);
            request.setAttribute("lowStockCount", 0);
        }

        request.getRequestDispatcher("/admin/report.jsp").forward(request, response);
    }
}