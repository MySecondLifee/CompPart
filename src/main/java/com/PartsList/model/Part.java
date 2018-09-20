package com.PartsList.model;



import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "part")
public class Part {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "namePart")
    private String namePart;

    @Column(name = "isBuild")
    private Character isBuild;

    @Column(name = "quantity")
    private int quantity;

    public Part() {
    }

    public Part(String namePart, Character isBuild, int quantity) {
        this.namePart = namePart;
        this.isBuild = isBuild;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNamePart() {
        return namePart;
    }

    public void setNamePart(String namePart) {
        this.namePart = namePart;
    }

    public Character getIsBuild() {
        return isBuild;
    }

    public void setIsBuild(Character isBuild) {
        this.isBuild = isBuild;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Part{" +
                "id=" + id +
                ", namePart='" + namePart + '\'' +
                ", isBuild=" + isBuild +
                ", quantity=" + quantity +
                '}';
    }
}
