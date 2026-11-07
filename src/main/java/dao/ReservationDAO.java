package dao;

import java.util.Date;
import java.util.List;

import entity.Reservation;

public interface ReservationDAO {
    void insert(Reservation reservation);
    void update(Reservation reservation);
    Reservation findById(Integer id);
    List<Reservation> findAll();
	void delete(Integer id);
	boolean existsReservation(Integer tableId, Date reservationTime);
	void confirm(Integer reservationId);
	void cancel(Integer reservationId);
	void complete(Integer reservationId);
	List<Reservation> findConfirmedReservations();
	List<Reservation> findTodayConfirmedReservations();
	List<Reservation> findByCustomer(Integer customerId);
	Reservation findByIdWithOrders(Integer reservationId);
	List<Reservation> search(String keyword);
}