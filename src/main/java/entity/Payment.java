package entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name="Payments")
public class Payment implements Serializable{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="PaymentID")
    private Integer paymentId;

    @ManyToOne
    @JoinColumn(name="OrderID")
    private Order order;

    @ManyToOne
    @JoinColumn(name="Username")
    private User user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="PaymentDate")
    private Date paymentDate = new Date();

    @Column(name="Amount")
    private Double amount;

    @Column(name="PaymentMethod")
    private String paymentMethod;

    @Column(name="Status")
    private String status = "SUCCESS";


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Payment() {
    }

    public Integer getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}