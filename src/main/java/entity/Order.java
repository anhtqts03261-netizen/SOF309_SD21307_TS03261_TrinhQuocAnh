package entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "Orders")
public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderID")
    private Integer orderId;

    @ManyToOne
    @JoinColumn(name = "TableID")
    private RestaurantTables restaurantTable;

    @ManyToOne
    @JoinColumn(name = "Username")
    private User user;

    @ManyToOne
    @JoinColumn(name = "CustomerID")
    private Customer customer;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "OrderDate")
    private Date orderDate = new Date();

    @Column(name = "TotalAmount")
    private Double totalAmount = 0.0;

    @Column(name = "Status", length = 20)
    private String status = "UNPAID"; // RESERVED, UNPAID, WAITING_PAYMENT, PAID, CANCELLED
    
    @OneToOne
    @JoinColumn(name="ReservationID")
    private Reservation reservation;

    // --- Constructors ---
    public Order() {}

    // --- Getters and Setters ---
    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public RestaurantTables getRestaurantTable() { return restaurantTable; }
    public void setRestaurantTable(RestaurantTables restaurantTable) { this.restaurantTable = restaurantTable; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    @OneToMany(mappedBy = "order",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<OrderDetail> orderDetails;

    public List<OrderDetail> getOrderDetails() {return orderDetails;}
    public void setOrderDetails(List<OrderDetail> orderDetails) {this.orderDetails = orderDetails;}

	public Reservation getReservation() {return reservation;}
	
	public void setReservation(Reservation reservation) {this.reservation = reservation;}
	public static long getSerialversionuid() {return serialVersionUID;}
	
	
}