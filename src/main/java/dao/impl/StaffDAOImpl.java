package dao.impl;

import java.util.ArrayList;
import java.util.List;

import dao.StaffDAO;
import entity.Staff;
import jakarta.persistence.EntityManager;
import util.JpaUtil;

public class StaffDAOImpl implements StaffDAO {
    @Override
    public List<Staff> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // Lấy tất cả user trừ ADMIN ra (hoặc lọc theo role tùy bạn)
            String jpql = "SELECT s FROM Staff s WHERE s.position != 'ADMIN'";
            return em.createQuery(jpql, Staff.class).getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}