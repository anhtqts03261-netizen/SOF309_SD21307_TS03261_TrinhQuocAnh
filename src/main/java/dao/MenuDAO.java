package dao;
import entity.Menu;
import java.util.List;

public interface MenuDAO {
    void insert(Menu entity);
    void update(Menu entity);
    void delete(Integer id);
    Menu findById(Integer id);
    List<Menu> findAll();
}