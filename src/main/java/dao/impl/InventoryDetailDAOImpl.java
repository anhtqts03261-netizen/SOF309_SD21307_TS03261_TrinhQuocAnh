package dao.impl;
import dao.InventoryDetailDAO;
import entity.InventoryDetail;
import jakarta.persistence.*;
import util.JpaUtil;
import java.util.List;

public class InventoryDetailDAOImpl implements InventoryDetailDAO {
    @Override
    public void insert(InventoryDetail e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void update(InventoryDetail e) {
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
        try { t.begin(); InventoryDetail e = em.find(InventoryDetail.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public InventoryDetail findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(InventoryDetail.class, id); } finally { em.close(); }
    }
    @Override
    public List<InventoryDetail> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT idet FROM InventoryDetail idet", InventoryDetail.class).getResultList(); } finally { em.close(); }
    }
    
    @Override
    public void save(InventoryDetail detail) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            em.persist(detail);

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
    public List<InventoryDetail> findByReceiptId(Integer receiptId){

        EntityManager em=JpaUtil.getEntityManager();

        try{

            String jpql=
            "SELECT d FROM InventoryDetail d " +
            "JOIN FETCH d.ingredient " +
            "WHERE d.inventoryReceipt.receiptId=:id";

            return em.createQuery(jpql,InventoryDetail.class)
                    .setParameter("id",receiptId)
                    .getResultList();

        }finally{

            em.close();

        }

    }
    
    @Override
    public List<InventoryDetail> findByReceipt(Integer receiptId){

        EntityManager em = JpaUtil.getEntityManager();

        try{

            String jpql="""
                    SELECT d
                    FROM InventoryDetail d
                    JOIN FETCH d.ingredient
                    WHERE d.inventoryReceipt.receiptId=:id
                    """;

            return em.createQuery(jpql,InventoryDetail.class)
                    .setParameter("id",receiptId)
                    .getResultList();

        }finally{

            em.close();

        }

    }
    
    @Override
    public InventoryDetail findByReceiptAndIngredient(Integer receiptId,
                                                      Integer ingredientId){

        EntityManager em=JpaUtil.getEntityManager();

        try{

            String jpql="""
                    SELECT d
                    FROM InventoryDetail d
                    WHERE d.inventoryReceipt.receiptId=:receipt
                    AND d.ingredient.ingredientId=:ingredient
                    """;

            List<InventoryDetail> list=
                    em.createQuery(jpql,InventoryDetail.class)
                    .setParameter("receipt",receiptId)
                    .setParameter("ingredient",ingredientId)
                    .getResultList();

            if(list.isEmpty())
                return null;

            return list.get(0);

        }finally{

            em.close();

        }

    }
}