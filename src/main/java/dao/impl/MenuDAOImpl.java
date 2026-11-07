package dao.impl;
import dao.MenuDAO;
import entity.Menu;
import jakarta.persistence.*;
import util.JpaUtil;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {
    @Override
    public void insert(Menu e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void update(Menu e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.merge(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); Menu e = em.find(Menu.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public Menu findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(Menu.class, id); } finally { em.close(); }
    }
    @Override
    public List<Menu> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT m FROM Menu m", Menu.class).getResultList(); } finally { em.close(); }
    }
}