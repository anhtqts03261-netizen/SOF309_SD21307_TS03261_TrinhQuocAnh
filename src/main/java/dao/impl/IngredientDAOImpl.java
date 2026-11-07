package dao.impl;
import dao.IngredientDAO;
import entity.Ingredient;
import jakarta.persistence.*;
import util.JpaUtil;
import java.util.List;

public class IngredientDAOImpl implements IngredientDAO {
    @Override
    public void insert(Ingredient e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void update(Ingredient e) {
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
        try { t.begin(); Ingredient e = em.find(Ingredient.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public Ingredient findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(Ingredient.class, id); } finally { em.close(); }
    }
    @Override
    public List<Ingredient> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT i FROM Ingredient i", Ingredient.class).getResultList(); } finally { em.close(); }
    }
    
    @Override
    public int countLowStock() {
        // 1. Khởi tạo EntityManager
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // 2. Thực hiện query
            String jpql = "SELECT COUNT(i) FROM Ingredient i WHERE i.quantity < 5";
            return ((Long) em.createQuery(jpql).getSingleResult()).intValue();
        } finally {
            // 3. Đóng EntityManager để tránh rò rỉ kết nối
            em.close();
        }
    }
    
    @Override
    public List<Ingredient> search(String keyword){

        EntityManager em = JpaUtil.getEntityManager();

        try{

            String jpql =
                    "SELECT i FROM Ingredient i " +
                    "WHERE LOWER(i.ingredientName) LIKE LOWER(:kw)";

            return em.createQuery(jpql, Ingredient.class)
                    .setParameter("kw","%"+keyword+"%")
                    .getResultList();

        }finally{
            em.close();
        }

    }
    
    @Override
    public int countIngredient(){

        EntityManager em = JpaUtil.getEntityManager();

        try{

            Long count=(Long)em.createQuery(

                    "SELECT COUNT(i) FROM Ingredient i"

            ).getSingleResult();

            return count.intValue();

        }finally{
            em.close();
        }

    }
    
    @Override
    public int countOutOfStock(){

        EntityManager em = JpaUtil.getEntityManager();

        try{

            Long count=(Long)em.createQuery(

                    "SELECT COUNT(i) FROM Ingredient i " +
                    "WHERE i.quantity=0"

            ).getSingleResult();

            return count.intValue();

        }finally{
            em.close();
        }

    }
    
    @Override
    public List<Ingredient> findAllActive() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "FROM Ingredient i WHERE i.isActive = true ORDER BY i.ingredientName",
                    Ingredient.class)
                    .getResultList();

        } finally {

            em.close();

        }
    }
    
    @Override
    public void updateQuantity(Integer ingredientId, Double quantity) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            Ingredient ingredient =
                    em.find(Ingredient.class, ingredientId);

            ingredient.setQuantity(quantity);

            em.merge(ingredient);

            trans.commit();

        } catch (Exception e) {

            trans.rollback();

            e.printStackTrace();

        } finally {

            em.close();

        }

    }
    
    @Override
    public int countAll() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = "SELECT COUNT(i) FROM Ingredient i";

            return ((Long) em.createQuery(jpql)
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }

    @Override
    public List<Ingredient> findLowStock() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT i FROM Ingredient i WHERE i.quantity <= i.minQuantity ORDER BY i.quantity";

            return em.createQuery(jpql, Ingredient.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
}