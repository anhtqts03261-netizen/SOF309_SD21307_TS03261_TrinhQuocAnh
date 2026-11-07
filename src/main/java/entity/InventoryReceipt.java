package entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "InventoryReceipts")
public class InventoryReceipt implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ReceiptID")
    private Integer receiptId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ReceiptDate")
    private Date receiptDate = new Date();

    @ManyToOne
    @JoinColumn(name = "Username")
    private User user; // Nhân viên thực hiện nhập kho

    @Column(name = "TotalAmount")
    private Double totalAmount = 0.0;
    
    @Column(name = "Type", nullable = false, length = 20)
    private String type;

    // --- Constructors ---
    public InventoryReceipt() {}

    // --- Getters and Setters ---
    public Integer getReceiptId() { return receiptId; }
    public void setReceiptId(Integer receiptId) { this.receiptId = receiptId; }

    public Date getReceiptDate() { return receiptDate; }
    public void setReceiptDate(Date receiptDate) { this.receiptDate = receiptDate; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    @OneToMany(mappedBy = "inventoryReceipt",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private java.util.List<InventoryDetail> details;

    public java.util.List<InventoryDetail> getDetails() {
        return details;
    }

    public void setDetails(java.util.List<InventoryDetail> details) {
        this.details = details;
    }
}