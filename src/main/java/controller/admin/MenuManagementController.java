package controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import dao.DishDAO;
import dao.impl.DishDAOImpl;
import entity.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import util.UploadUtil;

@WebServlet("/admin/menu")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
public class MenuManagementController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DishDAO dishDAO = new DishDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Dish> dishes = dishDAO.findAll();

        request.setAttribute("dishList", dishes);

        request.getRequestDispatcher("/admin/menu.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Dish dish = new Dish();

        dish.setDishName(request.getParameter("dishName"));

        dish.setPrice(
                Double.parseDouble(request.getParameter("price")));

        dish.setCategory(
                request.getParameter("category"));

        dish.setIsAvailable(
                request.getParameter("isAvailable") != null);

        // ================= Upload ảnh =================

        Part filePart = request.getPart("image");

        String fileName = "";

        if (filePart != null && filePart.getSize() > 0) {

            fileName = Paths.get(filePart.getSubmittedFileName())
                    .getFileName()
                    .toString();

            String uploadPath =
                    UploadUtil.getUploadPath(
                            getServletContext(),
                            "menu");

            System.out.println(uploadPath);

            System.out.println("UPLOAD PATH: " + uploadPath);

            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            System.out.println("UPLOAD PATH: " + uploadPath);

            filePart.write(uploadPath + File.separator + fileName);

        } else {

            dish.setImage(null);

        }

        // ==============================================

        dishDAO.insert(dish);

        response.sendRedirect(
                request.getContextPath() + "/admin/menu");
        
    }

}