package entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "MenuDishes")
public class MenuDish implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @ManyToOne
    @JoinColumn(name = "MenuID", nullable = false)
    private Menu menu;

    @Id
    @ManyToOne
    @JoinColumn(name = "DishID", nullable = false)
    private Dish dish;

    // --- Constructors ---
    public MenuDish() {}

    public MenuDish(Menu menu, Dish dish) {
        this.menu = menu;
        this.dish = dish;
    }

    // --- Getters and Setters ---
    public Menu getMenu() { return menu; }
    public void setMenu(Menu menu) { this.menu = menu; }

    public Dish getDish() { return dish; }
    public void setDish(Dish dish) { this.dish = dish; }

    // --- Override Equals & HashCode (Bắt buộc phải có khi làm khóa tổ hợp trong JPA) ---
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MenuDish menuDish = (MenuDish) o;
        return Objects.equals(menu, menuDish.menu) && Objects.equals(dish, menuDish.dish);
    }

    @Override
    public int hashCode() {
        return Objects.hash(menu, dish);
    }
}