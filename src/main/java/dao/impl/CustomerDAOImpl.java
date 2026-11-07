package dao.impl;

import dao.CustomerDAO;
import entity.Customer;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;
import java.util.List;

public class CustomerDAOImpl implements CustomerDAO {
    @Override
    public void insert(Customer entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); em.persist(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public void update(Customer entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); em.merge(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); Customer entity = em.find(Customer.class, id); if (entity != null) em.remove(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public Customer findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(Customer.class, id); }
        finally { em.close(); }
    }

    @Override
    public List<Customer> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT c FROM Customer c", Customer.class).getResultList(); }
        finally { em.close(); }
    }
    
    @Override
    public Customer login(String phone, String password) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            List<Customer> list = em.createQuery(
                    """
                    SELECT c
                    FROM Customer c
                    WHERE c.phone = :phone
                    AND c.password = :password
                    """,
                    Customer.class)
                    .setParameter("phone", phone)
                    .setParameter("password", password)
                    .getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {

            em.close();

        }

    }
    
    @Override
    public Customer findByPhone(String phone) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            List<Customer> list = em.createQuery(
                    """
                    SELECT c
                    FROM Customer c
                    WHERE c.phone = :phone
                    """,
                    Customer.class)
                    .setParameter("phone", phone)
                    .getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {

            em.close();

        }

    }
    
    @Override
    public boolean existsPhone(String phone) {

        return findByPhone(phone) != null;

    }
    
    @Override
    public boolean existsEmail(String email) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long count = em.createQuery(
                    """
                    SELECT COUNT(c)
                    FROM Customer c
                    WHERE c.email = :email
                    """,
                    Long.class)
                    .setParameter("email", email)
                    .getSingleResult();

            return count > 0;

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Customer> search(String keyword) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT c
                    FROM Customer c
                    WHERE c.fullName LIKE :keyword
                    OR c.phone LIKE :keyword
                    ORDER BY c.createdDate DESC
                    """;

            return em.createQuery(jpql, Customer.class)
                    .setParameter("keyword", "%" + keyword + "%")
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public void updateRank(Integer customerId, String rank) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Customer customer = em.find(Customer.class, customerId);

            if (customer != null) {

                customer.setRank(rank);

            }

            tx.commit();

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            e.printStackTrace();

        } finally {

            em.close();

        }

    }
    
    @Override
    public void updateStatus(Integer customerId, Boolean active) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Customer customer = em.find(Customer.class, customerId);

            if (customer != null) {

                customer.setIsActive(active);

            }

            tx.commit();

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            e.printStackTrace();

        } finally {

            em.close();

        }

    }
}