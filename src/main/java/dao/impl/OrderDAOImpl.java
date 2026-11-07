package dao.impl;
import java.util.List;

import dao.OrderDAO;
import entity.Order;
import entity.RestaurantTables;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;

public class OrderDAOImpl implements OrderDAO {
    @Override
    public void insert(Order e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void update(Order e) {
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
        try { t.begin(); Order e = em.find(Order.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public Order findById(Integer id){

        EntityManager em = JpaUtil.getEntityManager();

        try{

            String jpql =
                """
                SELECT DISTINCT o
                FROM Order o
                LEFT JOIN FETCH o.restaurantTable
                LEFT JOIN FETCH o.user
                LEFT JOIN FETCH o.customer
                LEFT JOIN FETCH o.orderDetails od
                LEFT JOIN FETCH od.dish
                WHERE o.orderId=:id
                """;

            return em.createQuery(jpql,Order.class)
                    .setParameter("id",id)
                    .getSingleResult();

        }finally{

            em.close();

        }

    }
    @Override
    public List<Order> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT o FROM Order o", Order.class).getResultList(); } finally { em.close(); }
    }
    
    @Override
    public int countOrders() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // Đếm tổng số đơn hàng
            String jpql = "SELECT COUNT(o) FROM Order o";
            return ((Long) em.createQuery(jpql).getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public double getTotalRevenue() {
    	System.out.println("DAO NEW VERSION");
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // Tổng doanh thu (thay 'totalPrice' bằng tên field thực tế trong Entity Order của bạn)
        	String jpql = "SELECT SUM(o.totalAmount) FROM Order o";
            Double result = (Double) em.createQuery(jpql).getSingleResult();
            return (result != null) ? result : 0.0;
        } finally {
            em.close();
        }
    }
    
    @Override
    public Order findUnpaidByTable(Integer tableId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                SELECT DISTINCT o
                FROM Order o
                LEFT JOIN FETCH o.restaurantTable
                LEFT JOIN FETCH o.user
                LEFT JOIN FETCH o.customer
                LEFT JOIN FETCH o.orderDetails od
                LEFT JOIN FETCH od.dish
                WHERE o.restaurantTable.tableId = :tableId
                AND o.status = 'UNPAID'
                """;

            List<Order> list = em.createQuery(jpql, Order.class)
                    .setParameter("tableId", tableId)
                    .getResultList();

            if (list.isEmpty()) {
                return null;
            }

            return list.get(0);

        } finally {

            em.close();

        }
    }
    
    @Override
    public double getTotalByOrder(Integer orderId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                "SELECT SUM(od.quantity * od.price) " +
                "FROM OrderDetail od " +
                "WHERE od.order.orderId = :id";

            Double total = em.createQuery(jpql, Double.class)
                    .setParameter("id", orderId)
                    .getSingleResult();

            return total == null ? 0.0 : total;

        } finally {

            em.close();

        }

    }
    
    @Override
    public void updateTotalAmount(Integer orderId) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            Order order = em.find(Order.class, orderId);

            if (order != null) {

                String jpql =
                    "SELECT SUM(od.quantity * od.price) " +
                    "FROM OrderDetail od " +
                    "WHERE od.order.orderId = :id";

                Double total = em.createQuery(jpql, Double.class)
                        .setParameter("id", orderId)
                        .getSingleResult();

                order.setTotalAmount(total == null ? 0.0 : total);

                em.merge(order);
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
    public void payment(Integer orderId) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            Order order = em.find(Order.class, orderId);

            if(order != null){

                order.setStatus("PAID");

                em.merge(order);

            }

            trans.commit();

        } catch(Exception e){

            trans.rollback();

            e.printStackTrace();

        } finally{

            em.close();

        }

    }
    
    @Override
    public List<Order> findUnpaidOrders() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT o
                    FROM Order o
                    LEFT JOIN FETCH o.customer
                    JOIN FETCH o.restaurantTable
                    JOIN FETCH o.user
                    WHERE o.status='UNPAID'
                    ORDER BY o.orderDate
                    """;

            return em.createQuery(jpql, Order.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Order> findWaitingPayment() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT o
                    FROM Order o
                    LEFT JOIN FETCH o.customer
                    JOIN FETCH o.restaurantTable
                    JOIN FETCH o.user
                    WHERE o.status='WAITING_PAYMENT'
                    ORDER BY o.orderDate
                    """;

            return em.createQuery(jpql, Order.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Order> findPaidOrders() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT o FROM Order o " +
                    "WHERE o.status='PAID' " +
                    "ORDER BY o.orderDate DESC";

            return em.createQuery(jpql, Order.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public void updateStatus(Integer orderId, String status) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Order order = em.find(Order.class, orderId);

            if(order != null){

                order.setStatus(status);

            }

            tx.commit();

        } catch(Exception e){

            if(tx.isActive())
                tx.rollback();

            throw e;

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Order> findByCustomer(Integer customerId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    """
                    SELECT o
                    FROM Order o
                    WHERE o.customer.customerId = :id
                    ORDER BY o.orderDate DESC
                    """,
                    Order.class)
                    .setParameter("id", customerId)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public int countByCustomer(Integer customerId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long count = em.createQuery(
                    """
                    SELECT COUNT(o)
                    FROM Order o
                    WHERE o.customer.customerId = :id
                    """,
                    Long.class)
                    .setParameter("id", customerId)
                    .getSingleResult();

            return count.intValue();

        } finally {

            em.close();

        }

    }
    
    @Override
    public Order findLatestByCustomer(Integer customerId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            List<Order> list = em.createQuery(
                    """
                    SELECT o
                    FROM Order o
                    WHERE o.customer.customerId = :id
                    ORDER BY o.orderDate DESC
                    """,
                    Order.class)
                    .setParameter("id", customerId)
                    .setMaxResults(1)
                    .getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {

            em.close();

        }

    }
    
    @Override
    public Order findByReservation(Integer reservationId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            List<Order> list = em.createQuery(
                    """
                    SELECT o
                    FROM Order o
                    LEFT JOIN FETCH o.restaurantTable
                    LEFT JOIN FETCH o.customer
                    LEFT JOIN FETCH o.user
                    LEFT JOIN FETCH o.reservation
                    LEFT JOIN FETCH o.orderDetails od
                    LEFT JOIN FETCH od.dish
                    WHERE o.reservation.reservationId = :id
                    """,
                    Order.class)
                    .setParameter("id", reservationId)
                    .getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {

            em.close();

        }

    }
    
    @Override
    public void assignWaiter(Integer orderId, String username) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Order order = em.find(Order.class, orderId);

            User waiter = em.find(User.class, username);

            if (order != null && waiter != null) {

                order.setUser(waiter);

                order.setStatus("UNPAID");

                em.merge(order);

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
    public boolean moveTable(Integer orderId, Integer newTableId) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            Order order = em.find(Order.class, orderId);

            if (order == null) {
                return false;
            }

            RestaurantTables oldTable = order.getRestaurantTable();

            RestaurantTables newTable =
                    em.find(RestaurantTables.class, newTableId);

            if (newTable == null) {
                return false;
            }

            if (!"EMPTY".equalsIgnoreCase(newTable.getStatus())) {
                return false;
            }

            oldTable.setStatus("EMPTY");
            newTable.setStatus("OCCUPIED");

            order.setRestaurantTable(newTable);

            em.merge(oldTable);
            em.merge(newTable);
            em.merge(order);

            transaction.commit();

            return true;

        } catch (Exception e) {

            if (transaction.isActive()) {
                transaction.rollback();
            }

            e.printStackTrace();

            return false;

        } finally {

            em.close();

        }

    }
}