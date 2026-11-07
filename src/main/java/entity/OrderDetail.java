package entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "OrderDetails")
public class OrderDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderDetailID")
    private Integer orderDetailId;

    @ManyToOne
    @JoinColumn(name = "OrderID", nullable = false)
    private Order order;

    @ManyToOne
    @JoinColumn(name = "DishID", nullable = false)
    private Dish dish;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    @Column(name = "Price", nullable = false)
    private Double price;

    @Column(name = "Note", length = 255)
    private String note;

    @Column(name = "ItemStatus", length = 20)
    private String itemStatus = "PENDING"; // 'PENDING', 'PREPARING', 'COMPLETED', 'SERVED', 'CANCELLED'

    // --- Constructors ---
    public OrderDetail() {}

    // --- Getters and Setters ---
    public Integer getOrderDetailId() { return orderDetailId; }
    public void setOrderDetailId(Integer orderDetailId) { this.orderDetailId = orderDetailId; }

    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }

    public Dish getDish() { return dish; }
    public void setDish(Dish dish) { this.dish = dish; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getItemStatus() { return itemStatus; }
    public void setItemStatus(String itemStatus) { this.itemStatus = itemStatus; }
}