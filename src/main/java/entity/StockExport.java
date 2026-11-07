package entity;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.*;

@Entity
@Table(name = "StockExports")
public class StockExport implements Serializable{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="ExportID")
    private Integer exportId;

    @ManyToOne
    @JoinColumn(name="OrderID")
    private Order order;

    @ManyToOne
    @JoinColumn(name="IngredientID")
    private Ingredient ingredient;

    @Column(name="Quantity")
    private Double quantity;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="ExportDate")
    private Date exportDate;

    @Column(name="Note")
    private String note;

    public StockExport() {
    }

    public Integer getExportId() {
        return exportId;
    }

    public void setExportId(Integer exportId) {
        this.exportId = exportId;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Date getExportDate() {
        return exportDate;
    }

    public void setExportDate(Date exportDate) {
        this.exportDate = exportDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}