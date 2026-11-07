package dao.impl;
import java.util.Date;
import java.util.List;

import dao.RestaurantTableDAO;
import entity.Order;
import entity.RestaurantTables;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;

public class RestaurantTableDAOImpl implements RestaurantTableDAO {
    @Override
    public void insert(RestaurantTables e) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction t = em.getTransaction();
        try { t.begin(); em.persist(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public void update(RestaurantTables e) {
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
        try { t.begin(); RestaurantTables e = em.find(RestaurantTables.class, id); if(e != null) em.remove(e); t.commit(); }
        catch (Exception ex) { t.rollback(); ex.printStackTrace(); }
        finally { em.close(); }
    }
    @Override
    public RestaurantTables findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.find(RestaurantTables.class, id); } finally { em.close(); }
    }
    @Override
    public List<RestaurantTables> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try { return em.createQuery("SELECT rt FROM RestaurantTables rt", RestaurantTables.class).getResultList(); } finally { em.close(); }
    }
    
    @Override
    public int countAll(){

        EntityManager em=JpaUtil.getEntityManager();

        try{

            Long total=em.createQuery(
                    "SELECT COUNT(t) FROM RestaurantTables t",
                    Long.class)
                    .getSingleResult();

            return total.intValue();

        }finally{

            em.close();

        }

    }
    
    @Override
    public int countEmpty(){

        EntityManager em=JpaUtil.getEntityManager();

        try{

            Long total=em.createQuery(
                    "SELECT COUNT(t) FROM RestaurantTables t WHERE t.status='EMPTY'",
                    Long.class)
                    .getSingleResult();

            return total.intValue();

        }finally{

            em.close();

        }

    }
    
    @Override
    public int countServing(){

        EntityManager em=JpaUtil.getEntityManager();

        try{

            Long total=em.createQuery(
                    "SELECT COUNT(t) FROM RestaurantTables t WHERE t.status='SERVING'",
                    Long.class)
                    .getSingleResult();

            return total.intValue();

        }finally{

            em.close();

        }

    }
    
    @Override
    public int countReserved(){

        EntityManager em=JpaUtil.getEntityManager();

        try{

            Long total=em.createQuery(
                    "SELECT COUNT(t) FROM RestaurantTables t WHERE t.status='RESERVED'",
                    Long.class)
                    .getSingleResult();

            return total.intValue();

        }finally{

            em.close();

        }

    }
    
    @Override
    public List<RestaurantTables> findAvailableTables(Date reservationTime, Integer guestCount) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                SELECT t
                FROM RestaurantTables t
                WHERE t.capacity >= :guestCount
                AND t.isActive = true
                AND t.status = 'EMPTY'
                AND t.tableId NOT IN (

                    SELECT r.restaurantTable.tableId

                    FROM Reservation r

                    WHERE r.status IN ('PENDING','CONFIRMED')
                    AND r.reservationTime = :reservationTime

                )

                ORDER BY t.capacity
                """;

            return em.createQuery(jpql, RestaurantTables.class)
                    .setParameter("guestCount", guestCount)
                    .setParameter("reservationTime", reservationTime)
                    .getResultList();

        } finally {

            em.close();

        }

    }
    
    @Override
    public void updateStatus(Integer tableId, String status) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            RestaurantTables table =
                    em.find(RestaurantTables.class, tableId);

            if (table != null) {

                table.setStatus(status);

                em.merge(table);

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
    public void mergeTable(Integer mainTableId,
                           Integer mergeTableId) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            RestaurantTables main =
                    em.find(RestaurantTables.class, mainTableId);

            RestaurantTables merge =
                    em.find(RestaurantTables.class, mergeTableId);

            if (main == null || merge == null) {
                trans.rollback();
                return;
            }

            // Nếu bàn chính đang là bàn phụ của cụm khác
            // thì lấy bàn gốc luôn
            Integer rootId =
                    main.getMergedWith() == null ?
                    main.getTableId()
                    :
                    main.getMergedWith();

            merge.setMergedWith(rootId);

            merge.setStatus("MERGED");

            em.merge(merge);

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
    public void unmergeTable(Integer tableId) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            List<RestaurantTables> list =
                    em.createQuery(
                            """
                            FROM RestaurantTables
                            WHERE mergedWith=:id
                            """,
                            RestaurantTables.class)
                            .setParameter("id", tableId)
                            .getResultList();

            for(RestaurantTables t:list){

                t.setMergedWith(null);

                t.setStatus("EMPTY");

                em.merge(t);

            }

            trans.commit();

        }catch(Exception e){

            if(trans.isActive())
                trans.rollback();

            throw e;

        }finally{

            em.close();

        }

    }
    
    @Override
    public void moveTable(Integer fromTableId,
                          Integer toTableId) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            RestaurantTables from =
                    em.find(RestaurantTables.class, fromTableId);

            RestaurantTables to =
                    em.find(RestaurantTables.class, toTableId);

            Order order =
                    em.createQuery(
                            """
                            FROM Order
                            WHERE restaurantTable.tableId=:id
                            AND status<>'PAID'
                            """,
                            Order.class)
                            .setParameter("id", fromTableId)
                            .getSingleResult();

            order.setRestaurantTable(to);

            // toàn bộ bàn phụ chuyển sang bàn mới

            List<RestaurantTables> mergedTables =
                    em.createQuery(
                            """
                            FROM RestaurantTables
                            WHERE mergedWith=:id
                            """,
                            RestaurantTables.class)
                            .setParameter("id", fromTableId)
                            .getResultList();

            for(RestaurantTables t : mergedTables){

                t.setMergedWith(toTableId);

                em.merge(t);

            }

            from.setStatus("EMPTY");
            from.setMergedWith(null);

            to.setStatus("SERVING");

            em.merge(order);
            em.merge(from);
            em.merge(to);

            trans.commit();

        } catch (Exception e) {

            if(trans.isActive())
                trans.rollback();

            throw e;

        } finally {

            em.close();

        }

    }
    
    @Override
    public void unmergeSingle(Integer tableId){

        EntityManager em=JpaUtil.getEntityManager();
        EntityTransaction trans=em.getTransaction();

        try{

            trans.begin();

            RestaurantTables table=
                    em.find(RestaurantTables.class,tableId);

            table.setMergedWith(null);

            em.merge(table);

            trans.commit();

        }catch(Exception e){

            if(trans.isActive())
                trans.rollback();

            throw e;

        }finally{

            em.close();

        }

    }
    
    @Override
    public void unmergeAll(Integer mainTableId){

        EntityManager em=JpaUtil.getEntityManager();
        EntityTransaction trans=em.getTransaction();

        try{

            trans.begin();

            List<RestaurantTables> list=
                    em.createQuery(
                            """
                            FROM RestaurantTables
                            WHERE mergedWith=:id
                            """,
                            RestaurantTables.class)
                            .setParameter("id",mainTableId)
                            .getResultList();

            for(RestaurantTables t:list){

                t.setMergedWith(null);

                em.merge(t);

            }

            trans.commit();

        }catch(Exception e){

            if(trans.isActive())
                trans.rollback();

            throw e;

        }finally{

            em.close();

        }

    }
    
}