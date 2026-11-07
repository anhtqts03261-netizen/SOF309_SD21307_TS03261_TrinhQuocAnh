package dao;

import entity.Dish; // Thay đổi theo từng Entity
import java.util.List;

public interface DishDAO { // Đảm bảo chữ interface ở đây
    void insert(Dish entity);
    void update(Dish entity);
    void delete(Integer id); // Hoặc String username cho UserDAO
    Dish findById(Integer id);
    List<Dish> findAll();
    List<Dish> findAvailable();
    List<Dish> searchByName(String keyword);
}