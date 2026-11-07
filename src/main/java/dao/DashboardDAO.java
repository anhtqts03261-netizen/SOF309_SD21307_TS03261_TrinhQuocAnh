package dao;

import java.util.List;

import entity.Order;
import entity.OrderDetail;
import entity.RestaurantTables;

public interface DashboardDAO {

    // ===== TABLE =====
    Long countAvailableTables();

    Long countOccupiedTables();

    Long countReservedTables();

    List<RestaurantTables> findAllTables();

    // ===== ORDER =====
    Long countUnpaidOrders();

    List<Order> findUnpaidOrders();

    // ===== KITCHEN =====
    Long countPendingItems();

    Long countCookingItems();

    Long countReadyItems();

    List<OrderDetail> findKitchenItems();

    // ===== CASHIER =====
    Double todayRevenue();

}