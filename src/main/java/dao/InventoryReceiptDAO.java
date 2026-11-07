package dao;
import entity.InventoryReceipt;
import java.util.List;

public interface InventoryReceiptDAO {
    void insert(InventoryReceipt entity);
    void update(InventoryReceipt entity);
    void delete(Integer id);
    InventoryReceipt findById(Integer id);
    List<InventoryReceipt> findAll();
    void save(InventoryReceipt receipt);
    int countAll();
    List<InventoryReceipt> findImportReceipts();
    List<InventoryReceipt> findExportReceipts();
    int countImport();
    int countExport();
}