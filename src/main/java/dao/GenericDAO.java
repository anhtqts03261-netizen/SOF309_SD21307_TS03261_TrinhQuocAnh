package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;
import java.util.List;

public abstract class GenericDAO<T> {
    private Class<T> entityClass;

    public GenericDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    public void insert(T entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); em.persist(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    public void update(T entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try { trans.begin(); em.merge(entity); trans.commit(); }
        catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    public void delete(Object id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            T entity = em.find(entityClass, id);
            if (entity != null) em.remove(entity);
            trans.commit();
        } catch (Exception e) { trans.rollback(); e.printStackTrace(); }
        finally { em.close(); }
    }

    public T findById(Object id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(entityClass, id); }
        finally { em.close(); }
    }

    public List<T> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT o FROM " + entityClass.getSimpleName() + " o";
            return em.createQuery(jpql, entityClass).getResultList();
        } finally { em.close(); }
    }
}