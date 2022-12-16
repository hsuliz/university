import {Route, Routes} from 'react-router-dom';
import './app.css';
import MenuComponent from './component/menu/menu-component';
import NavigationComponent from './component/navigation/navigation-component';
import HomeComponent from './component/home/home-component';
import ContactComponent from './component/contact/contact-component';
import React from 'react';
import SignUpComponent from './component/auth/signup/signup-component';
import LogInComponent from './component/auth/login/login-component';
import ProfileComponent from './component/profile/profile-component';


const App: React.FC = () => {
    return (
        <>
            <NavigationComponent/>
            <Routes>
                <Route path='/' element={<HomeComponent/>}/>
                <Route path='/menu' element={<MenuComponent/>}/>
                <Route path='/contact' element={<ContactComponent/>}/>
                <Route path='/signup' element={<SignUpComponent/>}/>
                <Route path='/login' element={<LogInComponent/>}/>
                <Route path='/profile' element={<ProfileComponent/>}/>
            </Routes>
        </>
    );
};

export default App;
