package controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.CartItem;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/client/reservation-add")
public class ReservationCartPageController extends HttpServlet {

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

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("reservationCart");

        if (cart == null) {

            cart = new ArrayList<>();

        }

        double total = 0;

        for (CartItem item : cart) {

            total += item.getTotal();

        }

        request.setAttribute("cart", cart);

        request.setAttribute("total", total);

        request.getRequestDispatcher(
                "/client/reservation-cart.jsp")
                .forward(request, response);

    }

}