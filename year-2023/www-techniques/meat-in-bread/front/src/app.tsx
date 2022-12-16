import {Route, Routes} from 'react-router-dom';
import './app.css';
import MenuComponent from './component/menu/menu-component';
import NavigationComponent from './component/navigation/navigation-component';
import HomeComponent from './component/home/home-component';
import ContactComponent from './component/contact/contact-component';
import React from 'react';
import LoginComponent from './component/auth/login/login-component';


const App: React.FC = () => {
    return (
        <>
            <NavigationComponent/>
            <Routes>
                <Route path="/" element={<HomeComponent/>}/>
                <Route path="/menu" element={<MenuComponent/>}/>
                <Route path="/contact" element={<ContactComponent/>}/>
                <Route path="/login" element={<LoginComponent/>}/>
            </Routes>
        </>
    );
};

export default App;
