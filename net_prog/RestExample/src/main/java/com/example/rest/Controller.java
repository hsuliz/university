package com.example.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/osoby")
public class Controller {

    private final PersonService personService;

    @Autowired
    public Controller(PersonService personService) {
        this.personService = personService;
    }


    @GetMapping("/search")
    public List<Person> get(
            @RequestParam("imie") String fname,
            @RequestParam("nazwisko") String lname
    ) {
        return personService.getPerson(fname, lname);
    }
}
