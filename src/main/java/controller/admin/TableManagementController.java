package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.RestaurantTableDAO;
import dao.impl.RestaurantTableDAOImpl;
import entity.RestaurantTables;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/tables")
public class TableManagementController extends HttpServlet {
    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	try {
            List<RestaurantTables> list = tableDAO.findAll(); // Lấy danh sách bàn
            // Nếu null thì gán list rỗng để JSP không lỗi
            request.setAttribute("tableList", list != null ? list : new ArrayList<>());
        } catch (Exception e) {
            System.out.println("Lỗi load bàn: " + e.getMessage());
            request.setAttribute("tableList", new ArrayList<>()); // Gán rỗng để không bị lỗi 500
        }
        request.getRequestDispatcher("/admin/tables.jsp").forward(request, response);
    }
}