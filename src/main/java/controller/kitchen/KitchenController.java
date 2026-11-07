package controller.kitchen;

import dao.OrderDetailDAO;
import dao.impl.OrderDetailDAOImpl;
import entity.OrderDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/kitchen/index")
//Lấy danh sách món chờ bếp
public class KitchenController extends HttpServlet {
//Controller tạo đối tượng DAO:
    private OrderDetailDAO dao = new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
//gọi
    	List<OrderDetail> queue = dao.findKitchenQueue();

    	System.out.println("===== KITCHEN =====");
    	System.out.println("Queue size = " + queue.size());

    	for (OrderDetail od : queue) {
    	    System.out.println(
    	        od.getOrderDetailId() + " | "
    	        + od.getDish().getDishName() + " | "
    	        + od.getItemStatus()
    	    );
    	}
//Dòng này đưa danh sách queue vào đối tượng request để JSP có thể đọc và hiển thị dữ liệu
    	request.setAttribute("queue", queue);

    	request.getRequestDispatcher("/kitchen/index.jsp")
    	       .forward(request, response);
    }
    
    
}