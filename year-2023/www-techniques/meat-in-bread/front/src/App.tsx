import React from 'react';
import Container from 'react-bootstrap/Container';
import SignupComponent from "./component/signup-component";
import {Link, Route, Routes} from "react-router-dom";
import './App.css';
import UserInfo from "./component/user-info";
import MenuComponent from "./component/menu-component";
import Navbar from "react-bootstrap/Navbar";
import {Nav, NavItem} from "react-bootstrap";


const App: React.FC = () => {

    return (
        <>
            <Navbar className="color-nav">
                <Container>
                    <Navbar.Brand>
                        Nigga
                    </Navbar.Brand>
                    <Nav className="me-auto">
                        <Link to={"/menu"} className="nav-link">Menu</Link>
                        <Link to={"/menu"} className="nav-link">User</Link>
                    </Nav>
                    <NavItem>
                        <Link to={"/menu"} className="nav-link accordion-button">
                            Log in
                        </Link>
                        <Link to={"/menu"} className="nav-link accordion-button">
                            Sign up
                        </Link>
                    </NavItem>
                </Container>
            </Navbar>
            <Container>
                <Routes>
                    <Route path='/home' element={<UserInfo/>}></Route>
                    <Route path='/menu' element={<MenuComponent/>}></Route>
                    <Route path='/login' element={< SignupComponent/>}></Route>
                </Routes>
            </Container>
        </>
    );
};

export default App;
