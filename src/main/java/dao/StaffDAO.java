package dao;
import entity.Staff;
import java.util.List;

public interface StaffDAO {
    List<Staff> findAll();
}