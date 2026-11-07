package controller.client;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;
import entity.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/client/register")
public class ClientRegisterController extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/client/register.jsp")
               .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");

        if(fullName.isBlank() ||
           phone.isBlank() ||
           email.isBlank() ||
           password.isBlank()){

            request.setAttribute("error",
                    "Vui lòng nhập đầy đủ thông tin.");

            doGet(request,response);

            return;
        }

        if(!password.equals(confirm)){

            request.setAttribute("error",
                    "Mật khẩu xác nhận không khớp.");

            doGet(request,response);

            return;
        }

        if(customerDAO.existsPhone(phone)){

            request.setAttribute("error",
                    "Số điện thoại đã tồn tại.");

            doGet(request,response);

            return;
        }

        if(customerDAO.existsEmail(email)){

            request.setAttribute("error",
                    "Email đã tồn tại.");

            doGet(request,response);

            return;
        }

        Customer customer = new Customer();

        customer.setFullName(fullName);
        customer.setPhone(phone);
        customer.setEmail(email);
        customer.setPassword(password);

        customer.setRank("BRONZE");
        customer.setCreatedDate(new Date());

        customerDAO.insert(customer);

        response.sendRedirect(
                request.getContextPath()
                        + "/client/login");

    }

}