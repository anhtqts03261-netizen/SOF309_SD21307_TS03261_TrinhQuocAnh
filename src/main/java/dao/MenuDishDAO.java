package dao;
import entity.MenuDish;
import java.util.List;
public interface MenuDishDAO {
    void insert(MenuDish entity);
    void delete(MenuDish entity); // Thường xóa bằng đối tượng với khóa tổ hợp
    List<MenuDish> findAll();
}