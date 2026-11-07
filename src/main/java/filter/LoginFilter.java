package filter;

import java.io.IOException;

import entity.Customer;
import entity.User;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class LoginFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request,
            HttpServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        String uri = request.getRequestURI();
        String context = request.getContextPath();

        HttpSession session = request.getSession(false);

        User user = null;
        Customer customer = null;

        if (session != null) {

            user = (User) session.getAttribute("user");

            customer = (Customer) session.getAttribute("customer");

        }

        //----------------------------
        // Public Pages
        //----------------------------

        if (uri.equals(context + "/")
                || uri.equals(context + "/index.jsp")
                || uri.equals(context + "/login")
                || uri.equals(context + "/client/login")
                || uri.equals(context + "/client/register")
                || uri.endsWith(".css")
                || uri.endsWith(".js")
                || uri.endsWith(".png")
                || uri.endsWith(".jpg")
                || uri.endsWith(".jpeg")
                || uri.endsWith(".gif")
                || uri.endsWith(".ico")) {

            chain.doFilter(request, response);

            return;

        }

        //----------------------------
        // ADMIN
        //----------------------------

        if (uri.startsWith(context + "/admin")) {

            if (user == null
                    || !"ADMIN".equals(user.getRole())) {

                response.sendRedirect(context + "/login");

                return;

            }

        }

        //----------------------------
        // WAITER
        //----------------------------

        if (uri.startsWith(context + "/waiter")) {

            if (user == null
                    || !"WAITER".equals(user.getRole())) {

                response.sendRedirect(context + "/login");

                return;

            }

        }

        //----------------------------
        // CHEF
        //----------------------------

        if (uri.startsWith(context + "/chef")
                || uri.startsWith(context + "/kitchen")) {

            if (user == null
                    || !"CHEF".equals(user.getRole())) {

                response.sendRedirect(context + "/login");

                return;

            }

        }

        //----------------------------
        // STOREKEEPER
        //----------------------------

        if (uri.startsWith(context + "/storekeeper")) {

            if (user == null
                    || !"STOREKEEPER".equals(user.getRole())) {

                response.sendRedirect(context + "/login");

                return;

            }

        }

        //----------------------------
        // CASHIER
        //----------------------------

        if (uri.startsWith(context + "/cashier")) {

            if (user == null
                    || !"CASHIER".equals(user.getRole())) {

                response.sendRedirect(context + "/login");

                return;

            }

        }

        //----------------------------
        // CLIENT
        //----------------------------

        if (uri.startsWith(context + "/client")) {

            // Cho phép truy cập trang login và register
            if (uri.equals(context + "/client/login")
                    || uri.equals(context + "/client/register")) {

                chain.doFilter(request, response);

                return;

            }

            if (customer == null) {

                response.sendRedirect(
                        context + "/client/login");

                return;

            }

        }

        chain.doFilter(request, response);

    }

}