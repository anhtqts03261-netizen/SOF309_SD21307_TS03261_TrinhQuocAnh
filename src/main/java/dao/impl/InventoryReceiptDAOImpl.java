package dao.impl;
import dao.InventoryReceiptDAO;
import entity.InventoryReceipt;
import jakarta.persistence.*;
import util.JpaUtil;
import java.util.List;

public class InventoryReceiptDAOImpl implements InventoryReceiptDAO {
    @Override
    public void insert(InventoryReceipt e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void update(InventoryReceipt e) {
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
        try { t.begin(); InventoryReceipt e = em.find(InventoryReceipt.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public InventoryReceipt findById(Integer id) {
    	
    	System.out.println("=== JOIN FETCH findById ===");

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.find(InventoryReceipt.class, id);

        } finally {

            em.close();

        }

    }
    @Override
    public List<InventoryReceipt> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT ir FROM InventoryReceipt ir", InventoryReceipt.class).getResultList(); } finally { em.close(); }
    }
    
    @Override
    public void save(InventoryReceipt receipt) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            em.persist(receipt);

            trans.commit();

        } catch (Exception e) {

            if (trans.isActive())
                trans.rollback();

            throw e;

        } finally {

            em.close();

        }

    }
    
    @Override
    public int countAll() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(r) FROM InventoryReceipt r";

            return ((Long) em.createQuery(jpql)
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<InventoryReceipt> findImportReceipts() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT r
                    FROM InventoryReceipt r
                    JOIN FETCH r.user
                    WHERE r.type='IMPORT'
                    ORDER BY r.receiptDate DESC
                    """;

            return em.createQuery(jpql,
                    InventoryReceipt.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<InventoryReceipt> findExportReceipts() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT r
                    FROM InventoryReceipt r
                    JOIN FETCH r.user
                    WHERE r.type='EXPORT'
                    ORDER BY r.receiptDate DESC
                    """;

            return em.createQuery(jpql,
                    InventoryReceipt.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public int countImport() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(r) FROM InventoryReceipt r WHERE r.type='IMPORT'";

            return ((Long) em.createQuery(jpql)
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }
    
    @Override
    public int countExport() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(r) FROM InventoryReceipt r WHERE r.type='EXPORT'";

            return ((Long) em.createQuery(jpql)
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }
}