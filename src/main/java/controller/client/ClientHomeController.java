package controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/client/home")
public class ClientHomeController extends HttpServlet {

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

        request.getRequestDispatcher("/client/home.jsp")
               .forward(request, response);

    }

}