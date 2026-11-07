package controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/client/logout")
public class ClientLogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session != null){

            session.removeAttribute("customer");

            session.invalidate();

        }

        response.sendRedirect(
                request.getContextPath()
                + "/");

    }

}