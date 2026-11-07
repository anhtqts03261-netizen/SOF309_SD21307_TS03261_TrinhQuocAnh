package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {
    private static final EntityManagerFactory factory = Persistence.createEntityManagerFactory("QLNhaHangPU");

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }

    public static void shutDown() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}