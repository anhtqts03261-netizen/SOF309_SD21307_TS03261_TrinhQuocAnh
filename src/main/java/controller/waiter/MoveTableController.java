package controller.waiter;

import dao.OrderDAO;
import dao.RestaurantTableDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.RestaurantTableDAOImpl;

import entity.Order;
import entity.RestaurantTables;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/waiter/move-table")
public class MoveTableController extends HttpServlet {

    private RestaurantTableDAO tableDAO =
            new RestaurantTableDAOImpl();

    private OrderDAO orderDAO =
            new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Integer tableId =
                Integer.parseInt(
                        request.getParameter("tableId"));

        String target =
                request.getParameter("targetTable");

        if (target == null) {

            request.setAttribute(
                    "fromTable",
                    tableId);

            request.setAttribute(
                    "tables",
                    tableDAO.findAll());

            request.getRequestDispatcher(
                    "/waiter/move-table.jsp")
                    .forward(request, response);

            return;
        }

        Integer targetId =
                Integer.parseInt(target);

        RestaurantTables from =
                tableDAO.findById(tableId);

        RestaurantTables to =
                tableDAO.findById(targetId);

        /*
         * Nếu đang chọn bàn phụ
         * thì chuyển luôn bàn chính.
         */
        if (from.getMergedWith() != null) {

            from =
                    tableDAO.findById(
                            from.getMergedWith());

        }

        Order order =
                orderDAO.findUnpaidByTable(
                        from.getTableId());

        if (order != null) {

            order.setRestaurantTable(to);

            orderDAO.update(order);

        }

        tableDAO.moveTable(
                from.getTableId(),
                targetId);

        response.sendRedirect(
                request.getContextPath()
                        + "/waiter/tables");

    }

}