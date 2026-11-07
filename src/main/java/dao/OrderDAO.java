package dao;
import entity.Order;
import java.util.List;

public interface OrderDAO {
	int countOrders();
    double getTotalRevenue();
    void insert(Order entity);
    void update(Order entity);
    void delete(Integer id);
    Order findById(Integer id);
    List<Order> findAll();
    Order findUnpaidByTable(Integer tableId);
    double getTotalByOrder(Integer orderId);
    void updateTotalAmount(Integer orderId);
    void payment(Integer orderId);
    List<Order> findUnpaidOrders();
    List<Order> findWaitingPayment();
    List<Order> findPaidOrders();
    void updateStatus(Integer orderId, String status);
    List<Order> findByCustomer(Integer customerId);
    int countByCustomer(Integer customerId);
    Order findLatestByCustomer(Integer customerId);
    Order findByReservation(Integer reservationId);
    void assignWaiter(Integer orderId, String username);
    boolean moveTable(Integer orderId, Integer newTableId);
}