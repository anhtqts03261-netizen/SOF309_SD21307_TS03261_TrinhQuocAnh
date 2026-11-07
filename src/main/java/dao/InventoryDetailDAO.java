package dao;
import entity.InventoryDetail;
import java.util.List;
public interface InventoryDetailDAO {
    void insert(InventoryDetail entity);
    void update(InventoryDetail entity);
    void delete(Integer id);
    InventoryDetail findById(Integer id);
    List<InventoryDetail> findAll();
    void save(InventoryDetail detail);
    List<InventoryDetail> findByReceiptId(Integer receiptId);
    List<InventoryDetail> findByReceipt(Integer receiptId);
    InventoryDetail findByReceiptAndIngredient(Integer receiptId, Integer ingredientId);
}