package controller.kitchen;

import dao.OrderDetailDAO;
import dao.impl.OrderDetailDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/kitchen/complete")
public class KitchenCompleteController extends HttpServlet {

    private OrderDetailDAO detailDAO =
            new OrderDetailDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Integer detailId =
                Integer.parseInt(
                        request.getParameter("detailId"));

        detailDAO.updateStatus(
                detailId,
                "COMPLETED");

        response.sendRedirect(
                request.getContextPath()
                + "/kitchen");

    }

}