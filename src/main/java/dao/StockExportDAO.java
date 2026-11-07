package dao;

import entity.StockExport;
import java.util.List;

public interface StockExportDAO {
    void insert(StockExport entity);
    List<StockExport> findAll();
    List<StockExport> findByOrder(Integer orderId);
    int countAll();
}