package entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "InventoryDetails")
public class InventoryDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "InventoryDetailID")
    private Integer inventoryDetailId;

    @ManyToOne
    @JoinColumn(name = "ReceiptID", nullable = false)
    private InventoryReceipt inventoryReceipt;

    @ManyToOne
    @JoinColumn(name = "IngredientID", nullable = false)
    private Ingredient ingredient;

    @Column(name = "Quantity", nullable = false)
    private Double quantity;

    @Column(name = "Price", nullable = false)
    private Double price;

    // --- Constructors ---
    public InventoryDetail() {}

    // --- Getters and Setters ---
    public Integer getInventoryDetailId() { return inventoryDetailId; }
    public void setInventoryDetailId(Integer inventoryDetailId) { this.inventoryDetailId = inventoryDetailId; }

    public InventoryReceipt getInventoryReceipt() { return inventoryReceipt; }
    public void setInventoryReceipt(InventoryReceipt inventoryReceipt) { this.inventoryReceipt = inventoryReceipt; }

    public Ingredient getIngredient() { return ingredient; }
    public void setIngredient(Ingredient ingredient) { this.ingredient = ingredient; }

    public Double getQuantity() { return quantity; }
    public void setQuantity(Double quantity) { this.quantity = quantity; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
}