package dao.impl;

import java.util.List;

import dao.DashboardDAO;
import entity.Order;
import entity.OrderDetail;
import entity.RestaurantTables;
import jakarta.persistence.EntityManager;
import util.JpaUtil;

public class DashboardDAOImpl implements DashboardDAO {

    @Override
    public Long countAvailableTables() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(t) FROM RestaurantTables t WHERE t.status = 'EMPTY'",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public Long countOccupiedTables() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(t) FROM RestaurantTables t WHERE t.status = 'OCCUPIED'",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public Long countReservedTables() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(t) FROM RestaurantTables t WHERE t.status = 'RESERVED'",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public List<RestaurantTables> findAllTables() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "FROM RestaurantTables",
                    RestaurantTables.class)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public Long countUnpaidOrders() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(o) FROM Order o WHERE o.status='UNPAID'",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Order> findUnpaidOrders() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "FROM Order o WHERE o.status='UNPAID' ORDER BY o.orderDate DESC",
                    Order.class)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public Long countPendingItems() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(d) FROM OrderDetail d WHERE d.itemStatus='PENDING'",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public Long countCookingItems() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(d) FROM OrderDetail d WHERE d.itemStatus='PREPARING'",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public Long countReadyItems() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(d) FROM OrderDetail d WHERE d.itemStatus='COMPLETED'",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    @Override
    public List<OrderDetail> findKitchenItems() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "FROM OrderDetail d " +
                    "WHERE d.itemStatus <> 'SERVED' " +
                    "ORDER BY d.order.orderDate",
                    OrderDetail.class)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public Double todayRevenue() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Double revenue = em.createQuery(
                    "SELECT SUM(o.totalAmount) " +
                    "FROM Order o " +
                    "WHERE o.status='PAID'",
                    Double.class)
                    .getSingleResult();

            return revenue == null ? 0.0 : revenue;

        } finally {
            em.close();
        }
    }
}