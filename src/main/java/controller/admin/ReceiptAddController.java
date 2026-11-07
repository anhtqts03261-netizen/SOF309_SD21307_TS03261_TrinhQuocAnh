package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.IngredientDAO;
import dao.impl.IngredientDAOImpl;
import entity.Ingredient;
import entity.InventoryDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/receipt/add")
public class ReceiptAddController extends HttpServlet {

    private IngredientDAO ingredientDAO = new IngredientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Ingredient> ingredients =
                ingredientDAO.findAllActive();

        request.setAttribute("ingredients", ingredients);
        
        HttpSession session=request.getSession();

        List<InventoryDetail> cart=
        (List<InventoryDetail>)
        session.getAttribute("receiptCart");

        request.setAttribute("cart",cart);

        request.getRequestDispatcher("/admin/receipt-add.jsp")
                .forward(request, response);

    }
    
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<InventoryDetail> cart =
                (List<InventoryDetail>) session.getAttribute("receiptCart");

        if(cart==null){

            cart=new ArrayList<>();

        }

        Integer ingredientId=
                Integer.parseInt(request.getParameter("ingredientId"));

        Double quantity=
                Double.parseDouble(request.getParameter("quantity"));

        Double price=
                Double.parseDouble(request.getParameter("price"));

        Ingredient ingredient=
                ingredientDAO.findById(ingredientId);

        InventoryDetail detail=new InventoryDetail();

        detail.setIngredient(ingredient);

        detail.setQuantity(quantity);

        detail.setPrice(price);

        boolean found = false;

        for (InventoryDetail d : cart) {

            if (d.getIngredient().getIngredientId()
                    .equals(ingredientId)) {

                d.setQuantity(
                        d.getQuantity() + quantity);

                d.setPrice(price);

                found = true;

                break;
            }

        }

        if (!found) {

            InventoryDetail details = new InventoryDetail();

            details.setIngredient(ingredient);

            details.setQuantity(quantity);

            details.setPrice(price);

            cart.add(details);

        }

        session.setAttribute("receiptCart",cart);

        response.sendRedirect(
                request.getContextPath()+"/admin/receipt/add");

    }

}