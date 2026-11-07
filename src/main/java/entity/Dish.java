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
@Table(name = "Dishes")
public class Dish implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DishID")
    private Integer dishId;

    @Column(name = "DishName", nullable = false, length = 100)
    private String dishName;

    @Column(name = "Price", nullable = false)
    private Double price;

    @Column(name = "Image", length = 255)
    private String image;

    @Column(name = "Category", length = 50)
    private String category; // 'Món chính', 'Khai vị', 'Đồ uống',...

    @Column(name = "IsAvailable")
    private Boolean isAvailable = true;
    
    @Column(name = "IsActive")
    private Boolean isActive = true;

    // --- Constructors ---
    public Dish() {}

    // --- Getters and Setters ---
    public Integer getDishId() { return dishId; }
    public void setDishId(Integer dishId) { this.dishId = dishId; }

    public String getDishName() { return dishName; }
    public void setDishName(String dishName) { this.dishName = dishName; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getImage() { return image; }
    public void setImage(String image ) { this.image = image; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean isAvailable) { this.isAvailable = isAvailable; }
    
    public Boolean getIsActive() {return isActive;}
	public void setIsActive(Boolean isActive) {		this.isActive = isActive;	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	@OneToMany(mappedBy = "dish",
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