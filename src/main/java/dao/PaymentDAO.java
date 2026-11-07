package dao;

import entity.Payment;
import java.util.List;

public interface PaymentDAO {
    void insert(Payment entity);
    void update(Payment entity);
    void delete(Integer id);
    Payment findById(Integer id);
    List<Payment> findAll();
    List<Payment> findByOrder(Integer orderId);
    Double todayRevenue();
    int todayPayment();
    Double totalRevenue();
    int countPayment();
}