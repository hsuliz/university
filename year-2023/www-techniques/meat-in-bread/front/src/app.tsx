import {Route, Routes} from 'react-router-dom';
import './app.css';
import MenuComponent from './component/menu/menu-component';
import NavigationBar from './component/navigation-bar/navigation-bar';
import HomeComponent from './component/home/home-component';
import ContactComponent from './component/contact/contact-component';
import React from 'react';


const App: React.FC = () => {
    return (
        <>
            <NavigationBar/>
            <Routes>
                <Route path='/' element={<HomeComponent/>}/>
                <Route path='/menu' element={<MenuComponent/>}/>
                <Route path='/contact' element={<ContactComponent/>}/>
            </Routes>
        </>
    );
};

export default App;
