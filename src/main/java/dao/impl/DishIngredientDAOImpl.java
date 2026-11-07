package dao.impl;

import dao.DishIngredientDAO;
import entity.DishIngredient;
import entity.DishIngredientId;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.JpaUtil;

import java.util.List;

public class DishIngredientDAOImpl implements DishIngredientDAO {

    @Override
    public void insert(DishIngredient entity) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            em.persist(entity);

            trans.commit();

        } catch (Exception e) {

            trans.rollback();
            e.printStackTrace();

        } finally {

            em.close();

        }

    }

    @Override
    public void update(DishIngredient entity) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            em.merge(entity);

            trans.commit();

        } catch (Exception e) {

            trans.rollback();
            e.printStackTrace();

        } finally {

            em.close();

        }

    }

    @Override
    public void delete(DishIngredientId id) {

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {

            trans.begin();

            DishIngredient entity =
                    em.find(DishIngredient.class, id);

            if (entity != null) {

                em.remove(entity);

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
    public DishIngredient findById(DishIngredientId id) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.find(DishIngredient.class, id);

        } finally {

            em.close();

        }

    }

    @Override
    public List<DishIngredient> findAll() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT d FROM DishIngredient d",
                    DishIngredient.class)
                    .getResultList();

        } finally {

            em.close();

        }

    }

    @Override
    public List<DishIngredient> findByDish(Integer dishId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql = """
                    SELECT di
                    FROM DishIngredient di
                    JOIN FETCH di.ingredient
                    WHERE di.dish.dishId = :dishId
                    """;

            return em.createQuery(jpql, DishIngredient.class)
                    .setParameter("dishId", dishId)
                    .getResultList();

        } finally {

            em.close();

        }

    }

}