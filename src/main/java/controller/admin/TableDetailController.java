package controller.admin;

import dao.DishDAO;
import dao.OrderDAO;
import dao.RestaurantTableDAO;

import dao.impl.DishDAOImpl;
import dao.impl.OrderDAOImpl;
import dao.impl.RestaurantTableDAOImpl;

import entity.Dish;
import entity.Order;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/table/detail")
public class TableDetailController extends HttpServlet {

    private RestaurantTableDAO tableDAO = new RestaurantTableDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();
    private DishDAO dishDAO = new DishDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Integer tableId =
                    Integer.parseInt(request.getParameter("id"));

            RestaurantTables table =
                    tableDAO.findById(tableId);

            if (table == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/table");

                return;

            }

            Order order =
                    orderDAO.findUnpaidByTable(tableId);

            List<Dish> dishes =
                    dishDAO.findAll();

            request.setAttribute("table", table);
            request.setAttribute("order", order);
            request.setAttribute("dishes", dishes);

            request.getRequestDispatcher(
                    "/admin/table-detail.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/table");

        }

    }

}