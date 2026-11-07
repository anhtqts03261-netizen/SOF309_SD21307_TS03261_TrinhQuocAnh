package entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Reservations")
public class Reservation implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ReservationID")
    private Integer reservationId;

    @Column(name = "CustomerName", nullable = false, length = 100)
    private String customerName;

    @Column(name = "Phone", nullable = false, length = 15)
    private String phone;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ReservationTime", nullable = false)
    private Date reservationTime;

    @Column(name = "GuestCount")
    private Integer guestCount;

    @ManyToOne
    @JoinColumn(name = "TableID")
    private RestaurantTables restaurantTable;

    @Column(name = "Status", length = 20)
    private String status = "PENDING"; // 'PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED'
    
    @Column(name = "Duration")
    private Integer duration = 120;
    
    @ManyToOne
	@JoinColumn(name="CustomerID")
	private Customer customer;
    
    @OneToOne(mappedBy = "reservation")
    private Order order;

    // --- Constructors ---
    public Reservation() {}

    // --- Getters and Setters ---
    public Integer getReservationId() { return reservationId; }
    public void setReservationId(Integer reservationId) { this.reservationId = reservationId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Date getReservationTime() { return reservationTime; }
    public void setReservationTime(Date reservationTime) { this.reservationTime = reservationTime; }

    public Integer getGuestCount() { return guestCount; }
    public void setGuestCount(Integer guestCount) { this.guestCount = guestCount; }

    public RestaurantTables getRestaurantTable() { return restaurantTable; }
    public void setRestaurantTable(RestaurantTables restaurantTable) { this.restaurantTable = restaurantTable; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

	public Integer getDuration() {return duration;}
	public void setDuration(Integer duration) {this.duration = duration;}

	public static long getSerialversionuid() {return serialVersionUID;}

	public Customer getCustomer() {return customer;}
	public void setCustomer(Customer customer) {this.customer = customer;}

	public Order getOrder() {return order;}
	public void setOrder(Order order) {this.order = order;}
}