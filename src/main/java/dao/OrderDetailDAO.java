package dao;
import entity.OrderDetail;
import java.util.List;
public interface OrderDetailDAO {
    void insert(OrderDetail entity);
    void update(OrderDetail entity);
    void delete(Integer id);
    OrderDetail findById(Integer id);
    List<OrderDetail> findAll();
    List<OrderDetail> findByOrderId(Integer orderId);
    OrderDetail findByOrderAndDish(Integer orderId, Integer dishId);
    List<OrderDetail> findKitchenQueue();
    List<OrderDetail> findByStatus(String status);
    void updateStatus(Integer detailId, String status);
    boolean allCompleted(Integer orderId);
}