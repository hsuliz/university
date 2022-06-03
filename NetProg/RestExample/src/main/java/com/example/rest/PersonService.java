package com.example.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PersonService {
    private final PersonRepo repo;

    @Autowired
    public PersonService(PersonRepo repo) {
        this.repo = repo;
    }


    public List<Person> getPerson(String fname, String lname) {
        return repo.getPersonByFNameAndLName(fname, lname);
    }
}
