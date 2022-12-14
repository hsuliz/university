import React from 'react';
import Container from 'react-bootstrap/Container';
import LoginComponent from "./component/login-component";
import {Link, Route, Routes} from "react-router-dom";
import './App.css';
import UserInfo from "./component/user-info";
import MenuComponent from "./component/menu-component";
import Navbar from "react-bootstrap/Navbar";
import {NavItem} from "react-bootstrap";


const App: React.FC = () => {

    return (
        <div>
            <Navbar className="color-nav">
                <Container>
                    <NavItem>
                        <Link to={"/menu"} className="nav-link">
                            Menu
                        </Link>

                    </NavItem>
                </Container>
            </Navbar>
            <Container>
                <Routes>
                    <Route path='/home' element={<UserInfo/>}></Route>
                    <Route path='/login' element={< LoginComponent/>}></Route>
                    <Route path='/menu' element={<MenuComponent/>}></Route>
                </Routes>
            </Container>
        </div>
    );
};

export default App;
