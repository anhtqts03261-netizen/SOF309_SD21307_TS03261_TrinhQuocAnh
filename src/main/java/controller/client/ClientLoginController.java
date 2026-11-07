package controller.client;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;
import entity.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/client/login")
public class ClientLoginController extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/client/login.jsp")
               .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        Customer customer =
                customerDAO.login(phone, password);

        if(customer == null){

            request.setAttribute("error",
                    "Sai số điện thoại hoặc mật khẩu.");

            doGet(request, response);

            return;

        }

        HttpSession session = request.getSession();

        session.setAttribute("customer", customer);

        response.sendRedirect(
                request.getContextPath()
                + "/client/home");

    }

}