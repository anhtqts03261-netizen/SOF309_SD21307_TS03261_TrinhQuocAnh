package entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Menus")
public class Menu implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MenuID")
    private Integer menuId;

    @Column(name = "MenuName", nullable = false, length = 100)
    private String menuName;

    @Column(name = "Description", length = 255)
    private String description;

    // --- Constructors ---
    public Menu() {}

    public Menu(String menuName, String description) {
        this.menuName = menuName;
        this.description = description;
    }

    // --- Getters and Setters ---
    public Integer getMenuId() { return menuId; }
    public void setMenuId(Integer menuId) { this.menuId = menuId; }

    public String getMenuName() { return menuName; }
    public void setMenuName(String menuName) { this.menuName = menuName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}