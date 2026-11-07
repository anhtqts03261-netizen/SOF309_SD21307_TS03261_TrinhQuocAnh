package dao;

import entity.DishIngredient;
import entity.DishIngredientId;

import java.util.List;

public interface DishIngredientDAO {
    void insert(DishIngredient entity);
    void update(DishIngredient entity);
    void delete(DishIngredientId id);
    DishIngredient findById(DishIngredientId id);
    List<DishIngredient> findAll();
    // Lấy toàn bộ nguyên liệu của một món
    List<DishIngredient> findByDish(Integer dishId);

}