package controller.admin;

import java.io.IOException;
import java.util.List;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.impl.CustomerDAOImpl;
import dao.impl.OrderDAOImpl;
import entity.Customer;
import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/customer-edit")
public class CustomerEditController extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        Integer id = Integer.valueOf(idParam);

        Customer customer = customerDAO.findById(id);

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        List<Order> orders = orderDAO.findByCustomer(id);

        int totalOrders = orderDAO.countByCustomer(id);

        Order latestOrder = orderDAO.findLatestByCustomer(id);

        request.setAttribute("customer", customer);
        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("latestOrder", latestOrder);

        request.getRequestDispatcher("/admin/customer-edit.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = Integer.valueOf(request.getParameter("customerId"));

        Customer customer = customerDAO.findById(id);

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        customer.setFullName(request.getParameter("fullName"));
        customer.setPhone(request.getParameter("phone"));
        customer.setEmail(request.getParameter("email"));

        customer.setRank(request.getParameter("rank"));

        customer.setIsMember(
                Boolean.parseBoolean(request.getParameter("isMember")));

        customer.setIsActive(
                Boolean.parseBoolean(request.getParameter("isActive")));

        customerDAO.update(customer);

        response.sendRedirect(request.getContextPath() + "/admin/customer-edit?id=" + id);

    }

}