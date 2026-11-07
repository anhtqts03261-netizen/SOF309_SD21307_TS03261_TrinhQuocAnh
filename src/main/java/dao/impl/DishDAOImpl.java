package dao.impl;

import dao.DishDAO;
import entity.Dish;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;
import java.util.List;

public class DishDAOImpl implements DishDAO {
    @Override
    public void insert(Dish entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); em.persist(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public void update(Dish entity) {
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
        try { trans.begin(); Dish entity = em.find(Dish.class, id); if (entity != null) em.remove(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    @Override
    public Dish findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(Dish.class, id); }
        finally { em.close(); }
    }

    @Override
    public List<Dish> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT d FROM Dish d", Dish.class).getResultList(); }
        finally { em.close(); }
    }
    
    @Override
    public List<Dish> findAvailable() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    """
                    SELECT d
                    FROM Dish d
                    WHERE d.isActive = true
                    ORDER BY d.dishName
                    """,
                    Dish.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Dish> searchByName(String keyword) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    """
                    SELECT d
                    FROM Dish d
                    WHERE d.isActive = true
                    AND LOWER(d.dishName)
                    LIKE LOWER(:kw)
                    ORDER BY d.dishName
                    """,
                    Dish.class)
                    .setParameter("kw", "%" + keyword + "%")
                    .getResultList();

        } finally {

            em.close();

        }

    }
}