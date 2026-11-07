package controller.admin;

import dao.DishDAO;
import dao.OrderDAO;
import dao.impl.DishDAOImpl;
import dao.impl.OrderDAOImpl;

import entity.Dish;
import entity.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order/detail")
public class OrderDetailController extends HttpServlet{

    private OrderDAO orderDAO = new OrderDAOImpl();

    private DishDAO dishDAO = new DishDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException,IOException{

        Integer id =
                Integer.parseInt(request.getParameter("id"));

        Order order =
                orderDAO.findById(id);

        List<Dish> dishes =
                dishDAO.findAll();

        request.setAttribute("order",order);

        request.setAttribute("dishes",dishes);

        request.getRequestDispatcher(
                "/admin/order-detail.jsp")
                .forward(request,response);

    }

}