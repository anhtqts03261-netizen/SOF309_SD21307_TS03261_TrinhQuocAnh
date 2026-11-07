package dao;
import entity.Ingredient;
import java.util.List;

public interface IngredientDAO {
	int countLowStock();
    void insert(Ingredient entity);
    void update(Ingredient entity);
    void delete(Integer id);
    Ingredient findById(Integer id);
    List<Ingredient> findAll();
    List<Ingredient> search(String keyword);
    int countIngredient();
    int countOutOfStock();
    List<Ingredient> findAllActive();
    void updateQuantity(Integer ingredientId, Double quantity);
    int countAll();
    List<Ingredient> findLowStock();
}