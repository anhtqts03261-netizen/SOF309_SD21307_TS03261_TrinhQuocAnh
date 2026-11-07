package dao.impl;

import dao.PaymentDAO;
import entity.Payment;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;

import java.util.List;

public class PaymentDAOImpl implements PaymentDAO {

    @Override
    public void insert(Payment entity) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            em.persist(entity);

            trans.commit();

        } catch (Exception e) {

            trans.rollback();

            e.printStackTrace();

        } finally {

            em.close();

        }

    }

    @Override
    public void update(Payment entity) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            em.merge(entity);

            trans.commit();

        } catch (Exception e) {

            trans.rollback();

            e.printStackTrace();

        } finally {

            em.close();

        }

    }

    @Override
    public void delete(Integer id) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            Payment payment = em.find(Payment.class, id);

            if (payment != null) {

                em.remove(payment);

            }

            trans.commit();

        } catch (Exception e) {

            trans.rollback();

            e.printStackTrace();

        } finally {

            em.close();

        }

    }

    @Override
    public Payment findById(Integer id) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.find(Payment.class, id);

        } finally {

            em.close();

        }

    }

    @Override
    public List<Payment> findAll() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT p
                    FROM Payment p
                    ORDER BY p.paymentDate DESC
                    """;

            return em.createQuery(jpql, Payment.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }

    @Override
    public List<Payment> findByOrder(Integer orderId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT p
                    FROM Payment p
                    WHERE p.order.orderId=:id
                    ORDER BY p.paymentDate DESC
                    """;

            return em.createQuery(jpql, Payment.class)
                    .setParameter("id", orderId)
                    .getResultList();

        } finally {

            em.close();

        }

    }

    @Override
    public Double todayRevenue() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT SUM(p.amount)
                    FROM Payment p
                    WHERE FUNCTION('CONVERT', DATE, p.paymentDate)
                    = FUNCTION('CONVERT', DATE, CURRENT_TIMESTAMP)
                    """;

            Double total = em.createQuery(jpql, Double.class)
                    .getSingleResult();

            return total == null ? 0.0 : total;

        } finally {

            em.close();

        }

    }

    @Override
    public int todayPayment() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT COUNT(p)
                    FROM Payment p
                    WHERE FUNCTION('CONVERT', DATE, p.paymentDate)
                    = FUNCTION('CONVERT', DATE, CURRENT_TIMESTAMP)
                    """;

            return ((Long) em.createQuery(jpql)
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }
    
    @Override
    public Double totalRevenue() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Double total = em.createQuery(
                    "SELECT SUM(p.amount) FROM Payment p",
                    Double.class)
                    .getSingleResult();

            return total == null ? 0.0 : total;

        } finally {

            em.close();

        }

    }

    @Override
    public int countPayment() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return ((Long) em.createQuery(
                    "SELECT COUNT(p) FROM Payment p")
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }

}