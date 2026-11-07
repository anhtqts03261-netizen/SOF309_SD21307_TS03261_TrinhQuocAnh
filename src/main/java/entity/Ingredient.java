package entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Ingredients")
public class Ingredient implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IngredientID")
    private Integer ingredientId;

    @Column(name = "IngredientName", nullable = false, length = 100)
    private String ingredientName;

    @Column(name = "Quantity", nullable = false)
    private Double quantity = 0.0;

    @Column(name = "Unit", nullable = false, length = 20)
    private String unit; // 'kg', 'chai', 'g',...

    @Column(name = "MinQuantity")
    private Double minQuantity = 0.0;
    
    @Column(name = "IsActive")
    private Boolean isActive = true;

    // --- Constructors ---
    public Ingredient() {}

    // --- Getters and Setters ---
    public Integer getIngredientId() { return ingredientId; }
    public void setIngredientId(Integer ingredientId) { this.ingredientId = ingredientId; }

    public String getIngredientName() { return ingredientName; }
    public void setIngredientName(String ingredientName) { this.ingredientName = ingredientName; }

    public Double getQuantity() { return quantity; }
    public void setQuantity(Double quantity) { this.quantity = quantity; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public Double getMinQuantity() { return minQuantity; }
    public void setMinQuantity(Double minQuantity) { this.minQuantity = minQuantity; }

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    
	@OneToMany(mappedBy = "ingredient",
	        cascade = CascadeType.ALL,
	        fetch = FetchType.LAZY)
	private List<DishIngredient> dishIngredients;

	public List<DishIngredient> getDishIngredients() {
	    return dishIngredients;
	}

	public void setDishIngredients(List<DishIngredient> dishIngredients) {
	    this.dishIngredients = dishIngredients;
	}
}