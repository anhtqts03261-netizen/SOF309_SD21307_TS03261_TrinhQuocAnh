package dao.impl;

import java.util.List;

import dao.UserDAO;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import util.JpaUtil;

public class UserDAOImpl implements UserDAO {
    @Override
    public void insert(User entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); em.persist(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public void update(User entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); em.merge(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public void delete(String username) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { 
            trans.begin(); 
            User entity = em.find(User.class, username);
            if (entity != null) em.remove(entity);
            trans.commit(); 
        }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public User findById(String username) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(User.class, username); }
        finally { em.close(); }
    }

    @Override
    public List<User> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT u FROM User u", User.class).getResultList(); }
        finally { em.close(); }
    }
    
    public User checkLogin(String username, String password) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // Chỉ dùng một câu lệnh JPQL duy nhất
            String jpql = "SELECT u FROM User u WHERE TRIM(u.username) = :user AND TRIM(u.password) = :pass";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            
            // Gán tham số chính xác vào query đã tạo
            query.setParameter("user", username);
            query.setParameter("pass", password);
            
            return query.getSingleResult(); // Lấy kết quả duy nhất
        } catch (Exception e) {
            System.out.println("Lỗi truy vấn: " + e.getMessage());
            return null; // Trả về null nếu sai pass hoặc user không tồn tại
        } finally {
            em.close();
        }
    }
    
    @Override
    public int countUsers() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = "SELECT COUNT(u) FROM User u";

            return ((Long) em.createQuery(jpql)
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }
    
    @Override
    public boolean existsByUsername(String username) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(u) FROM User u WHERE u.username=:user";

            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("user", username)
                    .getSingleResult();

            return count > 0;

        } finally {

            em.close();

        }

    }
    
    @Override
    public User findByUsername(String username) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.find(User.class, username);

        } finally {

            em.close();

        }

    }
    
    @Override
    public boolean changePassword(String username,
                                  String oldPassword,
                                  String newPassword) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            User user = em.find(User.class, username);

            if (user == null) {
                return false;
            }

            if (!user.getPassword().equals(oldPassword)) {
                return false;
            }

            tx.begin();

            user.setPassword(newPassword);

            em.merge(user);

            tx.commit();

            return true;

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            return false;

        } finally {

            em.close();

        }

    }
}