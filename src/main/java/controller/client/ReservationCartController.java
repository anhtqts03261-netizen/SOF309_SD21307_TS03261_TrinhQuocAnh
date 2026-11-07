package controller.client;

import dao.DishDAO;
import dao.impl.DishDAOImpl;
import entity.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/client/reservation-cart")
public class ReservationCartController extends HttpServlet {

    private DishDAO dishDAO = new DishDAOImpl();

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("reservationCart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");

        Integer dishId = Integer.parseInt(
                request.getParameter("dishId"));

        switch (action) {

            case "add":

                addDish(cart, dishId);

                break;

            case "minus":

                minusDish(cart, dishId);

                break;

            case "remove":

                removeDish(cart, dishId);

                break;

        }

        session.setAttribute("reservationCart", cart);

        response.sendRedirect(
                request.getContextPath()
                        + "/client/reservation-menu");

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String action = request.getParameter("action");

        if ("clear".equals(action)) {

            session.removeAttribute("reservationCart");

        }

        response.sendRedirect(
                request.getContextPath()
                        + "/client/reservation-menu");

    }

    private void addDish(List<CartItem> cart,
                         Integer dishId) {

        for (CartItem item : cart) {

            if (item.getDish().getDishId().equals(dishId)) {

                item.setQuantity(item.getQuantity() + 1);

                return;

            }

        }

        Dish dish = dishDAO.findById(dishId);

        cart.add(new CartItem(dish, 1));

    }

    private void minusDish(List<CartItem> cart,
                           Integer dishId) {

        CartItem removeItem = null;

        for (CartItem item : cart) {

            if (item.getDish().getDishId().equals(dishId)) {

                item.setQuantity(item.getQuantity() - 1);

                if (item.getQuantity() <= 0) {

                    removeItem = item;

                }

                break;

            }

        }

        if (removeItem != null) {

            cart.remove(removeItem);

        }

    }

    private void removeDish(List<CartItem> cart,
                            Integer dishId) {

        CartItem removeItem = null;

        for (CartItem item : cart) {

            if (item.getDish().getDishId().equals(dishId)) {

                removeItem = item;

                break;

            }

        }

        if (removeItem != null) {

            cart.remove(removeItem);

        }

    }

}