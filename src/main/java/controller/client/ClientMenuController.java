package controller.client;

import dao.DishDAO;
import dao.impl.DishDAOImpl;
import entity.Customer;
import entity.Dish;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/client/menu")
public class ClientMenuController extends HttpServlet {

    private DishDAO dishDAO = new DishDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           session.getAttribute("customer") == null){

            response.sendRedirect(
                    request.getContextPath()
                    + "/client/login");

            return;

        }

        Customer customer =
                (Customer) session.getAttribute("customer");

        List<Dish> dishes = dishDAO.findAll();

        request.setAttribute("customer", customer);
        request.setAttribute("dishes", dishes);

        request.getRequestDispatcher("/client/menu.jsp")
               .forward(request, response);

    }

}