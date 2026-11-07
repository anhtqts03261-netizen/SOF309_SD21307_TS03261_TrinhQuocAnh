package model;

import java.io.Serializable;

import entity.Dish;

public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private Dish dish;

    private int quantity;

    public CartItem() {

    }

    public CartItem(Dish dish, int quantity) {
        this.dish = dish;
        this.quantity = quantity;
    }

    public Dish getDish() {
        return dish;
    }

    public void setDish(Dish dish) {
        this.dish = dish;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotal() {
        return dish.getPrice() * quantity;
    }

}