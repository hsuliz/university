package com.example.rest;

import javax.persistence.*;

@Entity
@Table(name = "person")
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "FName")
    private String FName;

    @Column(name = "LName")
    private String LName;

    public Person() {
    }

    public Person(String FName, String LName) {
        this.FName = FName;
        this.LName = LName;
    }

    public Person(Long id, String FName, String LName) {
        this.id = id;
        this.FName = FName;
        this.LName = LName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFName() {
        return FName;
    }

    public void setFName(String FName) {
        this.FName = FName;
    }

    public String getLName() {
        return LName;
    }

    public void setLName(String LName) {
        this.LName = LName;
    }
}
