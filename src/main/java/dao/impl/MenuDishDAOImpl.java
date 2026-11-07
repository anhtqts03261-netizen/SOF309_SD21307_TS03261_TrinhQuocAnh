package dao.impl;
import dao.MenuDishDAO;
import entity.MenuDish;
import jakarta.persistence.*;
import util.JpaUtil;
import java.util.List;

public class MenuDishDAOImpl implements MenuDishDAO {
    @Override
    public void insert(MenuDish e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void delete(MenuDish e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.remove(em.contains(e) ? e : em.merge(e)); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public List<MenuDish> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT md FROM MenuDish md", MenuDish.class).getResultList(); } finally { em.close(); }
    }
}