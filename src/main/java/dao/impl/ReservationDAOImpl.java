package dao.impl;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import dao.ReservationDAO;
import entity.Customer;
import entity.Reservation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;

public class ReservationDAOImpl implements ReservationDAO {
    @Override
    public void insert(Reservation e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void update(Reservation e) {
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
        try { t.begin(); Reservation e = em.find(Reservation.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public Reservation findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(Reservation.class, id); } finally { em.close(); }
    }
    @Override
    public List<Reservation> findAll() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    """
                    SELECT r
                    FROM Reservation r
                    LEFT JOIN FETCH r.restaurantTable
                    LEFT JOIN FETCH r.customer
                    ORDER BY r.reservationTime
                    """,
                    Reservation.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public void confirm(Integer reservationId) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Reservation reservation =
                    em.find(Reservation.class, reservationId);

            if (reservation != null) {

                reservation.setStatus("CONFIRMED");

                em.merge(reservation);

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
    public boolean existsReservation(Integer tableId, Date reservationTime) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long count = em.createQuery(
                    """
                    SELECT COUNT(r)
                    FROM Reservation r
                    WHERE r.restaurantTable.tableId = :tableId
                    AND r.status IN ('PENDING','CONFIRMED')
                    AND r.reservationTime = :time
                    """,
                    Long.class)
                    .setParameter("tableId", tableId)
                    .setParameter("time", reservationTime)
                    .getSingleResult();

            return count > 0;

        } finally {

            em.close();

        }

    }
    
    @Override
    public void cancel(Integer reservationId) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Reservation reservation =
                    em.find(Reservation.class, reservationId);

            if (reservation != null) {

                reservation.setStatus("CANCELLED");

                em.merge(reservation);

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
    public void complete(Integer reservationId) {

        EntityManager em = JpaUtil.getEntityManager();

        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Reservation reservation =
                    em.find(Reservation.class, reservationId);

            if (reservation != null) {

                reservation.setStatus("COMPLETED");

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
    public List<Reservation> findConfirmedReservations() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    """
                    SELECT r
                    FROM Reservation r
                    LEFT JOIN FETCH r.restaurantTable
                    WHERE r.status = 'CONFIRMED'
                    ORDER BY r.reservationTime
                    """,
                    Reservation.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Reservation> findTodayConfirmedReservations() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Date today = new Date();

            Calendar c = Calendar.getInstance();
            c.setTime(today);

            c.set(Calendar.HOUR_OF_DAY,0);
            c.set(Calendar.MINUTE,0);
            c.set(Calendar.SECOND,0);

            Date start = c.getTime();

            c.set(Calendar.HOUR_OF_DAY,23);
            c.set(Calendar.MINUTE,59);
            c.set(Calendar.SECOND,59);

            Date end = c.getTime();

            return em.createQuery(
                    """
                    SELECT r
                    FROM Reservation r
                    LEFT JOIN FETCH r.restaurantTable
                    WHERE r.status='CONFIRMED'
                    AND r.reservationTime BETWEEN :start AND :end
                    ORDER BY r.reservationTime
                    """,
                    Reservation.class)
                    .setParameter("start", start)
                    .setParameter("end", end)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Reservation> findByCustomer(Integer customerId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    """
                    SELECT r
                    FROM Reservation r
                    LEFT JOIN FETCH r.restaurantTable
                    WHERE r.customer.customerId = :id
                    ORDER BY r.reservationTime DESC
                    """,
                    Reservation.class)
                    .setParameter("id", customerId)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public Reservation findByIdWithOrders(Integer reservationId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            List<Reservation> list = em.createQuery(
                    """
                    SELECT DISTINCT r
                    FROM Reservation r
                    LEFT JOIN FETCH r.restaurantTable
                    LEFT JOIN FETCH r.customer
                    WHERE r.reservationId = :id
                    """,
                    Reservation.class)
                    .setParameter("id", reservationId)
                    .getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {

            em.close();

        }

    }
    
    @Override
    public List<Reservation> search(String keyword){

        EntityManager em=JpaUtil.getEntityManager();

        try{

            return em.createQuery(
                    """
                    SELECT r
                    FROM Reservation r
                    LEFT JOIN FETCH r.restaurantTable
                    WHERE LOWER(r.customerName)
                    LIKE LOWER(:kw)

                    OR r.phone
                    LIKE :kw

                    ORDER BY r.reservationTime DESC
                    """,
                    Reservation.class)

                    .setParameter("kw","%"+keyword+"%")
                    .getResultList();

        }finally{

            em.close();

        }

    }
    
}