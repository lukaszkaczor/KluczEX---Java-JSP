package kluczex;

import java.util.ArrayList;
import java.util.List;

public class CartServletProduct {
    public String id;
    public String name;
    public String quantity;
    public List<String> keys = new ArrayList();

    public CartServletProduct(String id, String name, String quantity, List<String> keys) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.keys = keys;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public List<String> getKeys() {
        return keys;
    }

    public void setKeys(List<String> keys) {
        this.keys = keys;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

   
    
}
