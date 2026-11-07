package controller.admin;

import dao.StaffDAO;
import dao.impl.StaffDAOImpl;
import entity.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/staff")
public class StaffManagementController extends HttpServlet {
    private StaffDAO staffDAO = new StaffDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	List<Staff> list = staffDAO.findAll(); // Giả sử hàm của bạn tên là findAll()
    	System.out.println("Kiểm tra dữ liệu Staff: " + (list != null ? list.size() : "null"));

    	if (list != null) {
    	    for (Staff s : list) {
    	        System.out.println("Nhân viên: " + s.getName()); // Kiểm tra xem tên có bị null không
    	    }
    	}
    	request.setAttribute("staffList", list);
    	request.getRequestDispatcher("/admin/staff.jsp").forward(request, response);
    }
}