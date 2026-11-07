package controller.admin;

import java.io.IOException;
import java.util.List;

import dao.CustomerDAO;
import dao.impl.CustomerDAOImpl;
import entity.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/customers")
public class CustomerManagementController extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Customer> list;

        if(keyword == null || keyword.trim().isEmpty()){

            list = customerDAO.findAll();

        }else{

            list = customerDAO.search(keyword);

        }

        request.setAttribute("customers", list);

        request.getRequestDispatcher("/admin/customers.jsp")
               .forward(request, response);

    }

}