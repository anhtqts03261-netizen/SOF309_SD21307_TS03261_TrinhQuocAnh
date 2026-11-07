package dao;

import entity.Customer;
import java.util.List;

public interface CustomerDAO {
    Customer login(String phone, String password);
    Customer findById(Integer id);
    Customer findByPhone(String phone);
    boolean existsPhone(String phone);
    boolean existsEmail(String email);
    void insert(Customer customer);
    void update(Customer customer);
	void delete(Integer id);
	List<Customer> findAll();
	List<Customer> search(String keyword);
	void updateRank(Integer customerId, String rank);
	void updateStatus(Integer customerId, Boolean active);
}