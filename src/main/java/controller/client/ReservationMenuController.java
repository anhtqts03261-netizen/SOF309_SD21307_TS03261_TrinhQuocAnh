package controller.client;

import dao.DishDAO;
import dao.impl.DishDAOImpl;
import entity.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/client/reservation-menu")
public class ReservationMenuController extends HttpServlet {

    private DishDAO dishDAO = new DishDAOImpl();

    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("customer") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/client/login");

            return;
        }

        List<Dish> dishes = dishDAO.findAll();

        request.setAttribute("dishes", dishes);

        // =============================
        // Tạo Map<DishID, Quantity>
        // =============================

        Map<Integer, Integer> quantityMap = new HashMap<>();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("reservationCart");

        if (cart != null) {

            for (CartItem item : cart) {

                quantityMap.put(
                        item.getDish().getDishId(),
                        item.getQuantity());

            }

        }

        request.setAttribute("quantityMap", quantityMap);

        request.getRequestDispatcher(
                "/client/reservation-menu.jsp")
                .forward(request, response);

    }

}