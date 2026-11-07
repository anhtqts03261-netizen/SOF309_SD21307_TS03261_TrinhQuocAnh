package dao;

import entity.User;
import java.util.List;

public interface UserDAO {
    void insert(User entity);
    void update(User entity);
    void delete(String username);
    User findById(String username);
    User checkLogin(String username, String password);
    List<User> findAll();
    int countUsers();
    boolean existsByUsername(String username);
    User findByUsername(String username);
    boolean changePassword(String username,
            String oldPassword,
            String newPassword);
}