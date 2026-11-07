package controller.kitchen;

import dao.DishIngredientDAO;
import dao.IngredientDAO;
import dao.OrderDetailDAO;
import dao.StockExportDAO;

import dao.impl.DishIngredientDAOImpl;
import dao.impl.IngredientDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import dao.impl.StockExportDAOImpl;

import entity.DishIngredient;
import entity.Ingredient;
import entity.OrderDetail;
import entity.StockExport;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/kitchen/preparing")
//Nhận món, đổi trạng thái sang
public class KitchenPreparingController extends HttpServlet {

    private OrderDetailDAO detailDAO =
            new OrderDetailDAOImpl();

    private DishIngredientDAO recipeDAO =
            new DishIngredientDAOImpl();

    private IngredientDAO ingredientDAO =
            new IngredientDAOImpl();

    private StockExportDAO exportDAO =
            new StockExportDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Integer detailId =
                Integer.parseInt(request.getParameter("detailId"));

        OrderDetail detail =
        		//Lấy OrderDetail theo ID.
                detailDAO.findById(detailId);

        // Không cho nhận món lần 2
        if (!"PENDING".equals(detail.getItemStatus())) {

            response.sendRedirect(
                    request.getContextPath() + "/kitchen");

            return;
        }
//Lấy công thức của món ăn
        List<DishIngredient> recipes =
                recipeDAO.findByDish(
                        detail.getDish().getDishId());

        // ===============================
        // Kiểm tra đủ nguyên liệu
        // ===============================

        for (DishIngredient recipe : recipes) {

            Ingredient ingredient =
                    recipe.getIngredient();

            double need =
                    recipe.getRequiredQuantity()
                    * detail.getQuantity();

            if (ingredient.getQuantity() < need) {

                request.getSession().setAttribute(
                        "error",
                        "Không đủ nguyên liệu: "
                                + ingredient.getIngredientName());

                response.sendRedirect(
                        request.getContextPath() + "/kitchen");

                return;
            }

        }

        // ===============================
        // Xuất kho
        // ===============================

        for (DishIngredient recipe : recipes) {

            Ingredient ingredient =
                    recipe.getIngredient();

            double used =
                    recipe.getRequiredQuantity()
                    * detail.getQuantity();

            ingredient.setQuantity(
                    ingredient.getQuantity() - used);
//Cập nhật số lượng nguyên liệu sau khi trừ
            ingredientDAO.update(ingredient);

            StockExport export =
                    new StockExport();

            export.setOrder(detail.getOrder());

            export.setIngredient(ingredient);

            export.setQuantity(used);

            export.setExportDate(new Date());

            export.setNote(
                    "Xuất tự động khi bếp nhận món - Order "
                            + detail.getOrder().getOrderId());
//Lưu phiếu xuất kho.
            exportDAO.insert(export);

        }

        // ===============================
        // Cập nhật trạng thái
        // ===============================

        detailDAO.updateStatus(
                detailId,
                "PREPARING");

        request.getSession().setAttribute(
                "success",
                "Đã nhận món và xuất kho thành công.");

        response.sendRedirect(
                request.getContextPath() + "/kitchen");
    }

}