package dao.impl;

import dao.StockExportDAO;
import entity.StockExport;
import jakarta.persistence.*;

import util.JpaUtil;

import java.util.List;

public class StockExportDAOImpl
        implements StockExportDAO{

    @Override
    public void insert(StockExport entity){

        EntityManager em =
                JpaUtil.getEntityManager();

        EntityTransaction trans =
                em.getTransaction();

        try{

            trans.begin();

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
    public List<StockExport> findAll(){

        EntityManager em =
                JpaUtil.getEntityManager();

        try{

            String jpql="""
                    SELECT s
                    FROM StockExport s
                    JOIN FETCH s.order
                    JOIN FETCH s.ingredient
                    ORDER BY s.exportDate DESC
                    """;

            return em.createQuery(jpql,
                    StockExport.class)
                    .getResultList();

        }finally{

            em.close();

        }

    }

    @Override
    public List<StockExport> findByOrder(Integer orderId){

        EntityManager em =
                JpaUtil.getEntityManager();

        try{

            String jpql="""
                    SELECT s
                    FROM StockExport s
                    JOIN FETCH s.ingredient
                    WHERE s.order.orderId=:id
                    """;

            return em.createQuery(jpql,
                    StockExport.class)
                    .setParameter("id",orderId)
                    .getResultList();

        }finally{

            em.close();

        }

    }
    
    @Override
    public int countAll() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(s) FROM StockExport s";

            return ((Long) em.createQuery(jpql)
                    .getSingleResult()).intValue();

        } finally {

            em.close();

        }

    }

}