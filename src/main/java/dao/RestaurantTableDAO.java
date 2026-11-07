package dao;
import java.util.Date;
import java.util.List;

import entity.RestaurantTables;
public interface RestaurantTableDAO {
    void insert(RestaurantTables entity);
    void update(RestaurantTables entity);
    void delete(Integer id);
    RestaurantTables findById(Integer id);
    List<RestaurantTables> findAll();
    int countAll();
    int countEmpty();
    int countServing();
    int countReserved();
	List<RestaurantTables> findAvailableTables(Date reservationTime, Integer guestCount);
	void updateStatus(Integer tableId, String status);
//	boolean mergeTable(Integer mainTableId, Integer mergeTableId);
//	boolean unmergeTable(Integer mergeTableId);
	void mergeTable(Integer mainTableId, Integer mergeTableId);
	void moveTable(Integer fromTableId, Integer toTableId);
	public void unmergeTable(Integer tableId);
	void unmergeSingle(Integer tableId);
	void unmergeAll(Integer mainTableId);
}