package com.hendisantika.model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;

import java.util.Set;

/**
 * Created by hendisantika on 24/12/16.
 */

@Entity
public class CustomerOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long orderId;

    private Double total;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE} , fetch = FetchType.LAZY)
    @JoinTable(name = "ORDER_PRODUCTS", joinColumns = {@JoinColumn(name = "ORDER_ID")},inverseJoinColumns = {@JoinColumn(name = "PRODUCT_ID")})
    private Set<Product> products;

    @OneToOne
    private Customer customer;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }


    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Set<Product> getProducts() {
        return products;
    }

    public void setProducts(Set<Product> products) {
        this.products = products;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }


}
