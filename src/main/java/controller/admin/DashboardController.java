package controller.admin;

import dao.OrderDAO;
import dao.ReservationDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.ReservationDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardController extends HttpServlet {
    
    // Khởi tạo các DAO cần thiết để lấy dữ liệu thống kê
    private OrderDAO orderDAO = new OrderDAOImpl();
    private ReservationDAO resDAO = new ReservationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy dữ liệu thống kê từ database
        // Sử dụng size() để đếm số lượng bản ghi
        int totalOrders = orderDAO.findAll().size();
        int totalReservations = resDAO.findAll().size();
        
        // Gửi dữ liệu sang trang JSP
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalReservations", totalReservations);
        
        // Đường dẫn tới file JSP (đã bỏ /views theo yêu cầu của bạn)
        // Bạn hãy đảm bảo file dashboard.jsp nằm tại /admin/dashboard.jsp
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}