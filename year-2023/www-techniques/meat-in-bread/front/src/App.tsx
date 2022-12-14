import React from 'react';
import LoginComponent from "./component/login-component";
import {Link, Route, Routes} from "react-router-dom";
import './App.css';
import UserInfo from "./component/user-info";
import MenuComponent from "./component/menu-component";

const App: React.FC = () => {

    return (
        <div>
            <nav className="navbar navbar-expand navbar-dark bg-dark">
                <div className="navbar-nav mr-auto">
                    <li className="nav-item">
                        <Link to={"/home"} className="nav-link">
                            Home page
                        </Link>
                    </li>
                </div>
            </nav>
            <div className="container mt-3">
                <Routes>
                    <Route path='/home' element={<UserInfo/>}></Route>
                    <Route path='/login' element={< LoginComponent/>}></Route>
                    <Route path='/menu' element={<MenuComponent/>}></Route>
                </Routes>
            </div>
        </div>
    );
};

export default App;
