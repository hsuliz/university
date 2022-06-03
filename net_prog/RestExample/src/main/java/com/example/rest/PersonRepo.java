package com.example.rest;

import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PersonRepo extends CrudRepository<Person, Long> {
    public List<Person> getPersonByFNameAndLName(String FName, String LName);
}

