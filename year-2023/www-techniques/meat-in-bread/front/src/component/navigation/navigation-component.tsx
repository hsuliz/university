import {Container, Nav, Navbar} from 'react-bootstrap';
import React from 'react';
import {Link} from 'react-router-dom';
import './style.css';

const NavigationComponent = () => {
    return (
        <Navbar
            collapseOnSelect
            className="nav-color"
            expand="sm"
            variant="dark"
        >
            <Container>
                <Navbar.Brand as={Link} to="/">MEAT&BREAD</Navbar.Brand>
                <Navbar.Toggle aria-controls="responsive-navbar-nav"/>
                <Navbar.Collapse id="responsive-navbar-nav">
                    <Nav className="me-auto">
                        <Nav.Link as={Link} to="/menu">Menu</Nav.Link>
                        <Nav.Link as={Link} to="/contact">Contact</Nav.Link>
                    </Nav>
                    <Nav>
                        <Nav.Link as={Link} to="/login">Log in</Nav.Link>
                        <Nav.Link as={Link} to="/signup">Sign up</Nav.Link>
                    </Nav>
                </Navbar.Collapse>
            </Container>
        </Navbar>
    );
};

export default NavigationComponent;
