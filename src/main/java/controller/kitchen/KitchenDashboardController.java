package controller.kitchen;

import dao.DashboardDAO;
import dao.impl.DashboardDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/kitchen/dashboard")
public class KitchenDashboardController extends HttpServlet {

    private DashboardDAO dao = new DashboardDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session==null || session.getAttribute("user")==null){
            response.sendRedirect(request.getContextPath()+"/login");
            return;
        }

        request.setAttribute("pending", dao.countPendingItems());//Đếm món đang chờ
        request.setAttribute("preparing", dao.countCookingItems());//Đếm món đang nấu
        request.setAttribute("completed", dao.countReadyItems());//Đếm món đã hoàn thành

        request.setAttribute("items",
                dao.findKitchenItems());//Lấy danh sách món hiển thị Dashboard	

        request.getRequestDispatcher(
                "/kitchen/dashboard.jsp")
                .forward(request,response);

    }

}