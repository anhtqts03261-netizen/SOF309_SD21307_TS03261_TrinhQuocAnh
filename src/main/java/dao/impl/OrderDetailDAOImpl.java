package dao.impl;
import dao.OrderDetailDAO;
import entity.OrderDetail;
import jakarta.persistence.*;
import util.JpaUtil;
import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO {
	public void insert(OrderDetail entity){

	    EntityManager em = JpaUtil.getEntityManager();
	    EntityTransaction trans = em.getTransaction();

	    try{

	        trans.begin();

	        entity.setOrder(
	            em.merge(entity.getOrder())
	        );

	        entity.setDish(
	            em.merge(entity.getDish())
	        );

	        em.persist(entity);

	        trans.commit();

	    }catch(Exception e){

	        trans.rollback();
	        e.printStackTrace();

	    }finally{

	        em.close();

	    }

	}
    @Override
    public void update(OrderDetail e) {
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
        try { t.begin(); OrderDetail e = em.find(OrderDetail.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public OrderDetail findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(OrderDetail.class, id); } finally { em.close(); }
    }
    @Override
    public List<OrderDetail> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT od FROM OrderDetail od", OrderDetail.class).getResultList(); } finally { em.close(); }
    }
    
    @Override
    public List<OrderDetail> findByOrderId(Integer orderId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT od FROM OrderDetail od WHERE od.order.orderId = :id";

            return em.createQuery(jpql, OrderDetail.class)
                     .setParameter("id", orderId)
                     .getResultList();

        } finally {
            em.close();
        }
    }
    
    @Override
    public OrderDetail findByOrderAndDish(Integer orderId, Integer dishId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT od FROM OrderDetail od " +
                    "WHERE od.order.orderId=:orderId " +
                    "AND od.dish.dishId=:dishId";

            List<OrderDetail> list = em.createQuery(jpql, OrderDetail.class)
                    .setParameter("orderId", orderId)
                    .setParameter("dishId", dishId)
                    .getResultList();

            if(list.isEmpty()) {
                return null;
            }

            return list.get(0);

        } finally {
            em.close();
        }
    }
    
    @Override
    public List<OrderDetail> findKitchenQueue() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT od
                    FROM OrderDetail od
                    JOIN FETCH od.order o
                    JOIN FETCH o.restaurantTable
                    JOIN FETCH od.dish
                    WHERE od.itemStatus IN ('PENDING','PREPARING')
                    ORDER BY o.orderDate
                    """;

            return em.createQuery(jpql, OrderDetail.class)
                    .getResultList();

        } finally {
            em.close();
        }
    }
    
    @Override
    public List<OrderDetail> findByStatus(String status) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT od
                    FROM OrderDetail od
                    JOIN FETCH od.order o
                    JOIN FETCH o.restaurantTable
                    JOIN FETCH od.dish
                    WHERE od.itemStatus=:status
                    ORDER BY o.orderDate
                    """;

            return em.createQuery(jpql, OrderDetail.class)
                    .setParameter("status", status)
                    .getResultList();

        } finally {
            em.close();
        }

    }
    
    @Override
    public void updateStatus(Integer detailId, String status) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            OrderDetail detail =
                    em.find(OrderDetail.class, detailId);

            if(detail != null){

                detail.setItemStatus(status);

                em.merge(detail);

            }

            trans.commit();

        }catch(Exception e){

            trans.rollback();

            e.printStackTrace();

        }finally{

            em.close();

        }

    }
    
    @Override
    public boolean allCompleted(Integer orderId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long count = em.createQuery(
                    """
                    SELECT COUNT(od)
                    FROM OrderDetail od
                    WHERE od.order.orderId = :id
                    AND od.itemStatus <> 'SERVED'
                    """,
                    Long.class)
                    .setParameter("id", orderId)
                    .getSingleResult();

            return count == 0;

        } finally {

            em.close();

        }

    }
}