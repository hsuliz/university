import {Navigate, Route, Routes} from 'react-router-dom';
import './app.css';
import MenuComponent from './component/menu/menu-component';
import NavigationComponent from './component/navigation/navigation-component';
import HomeComponent from './component/home/home-component';
import ContactComponent from './component/contact/contact-component';
import React, {useEffect, useState} from 'react';
import SignUpComponent from './component/auth/signup/signup-component';
import LogInComponent from './component/auth/login/login-component';
import ProfileComponent from './component/profile/profile-component';
import {isAuth} from './service/user-auth';


const App: React.FC = () => {

    const [auth, setAuth] = useState<boolean>(false);

    const ProtectedRoute = ({auth, children}) => {
        if (!auth) {
            return <Navigate to='/login' replace/>;
        }
        return children;
    };

    const ProtectedRouteForAuth = ({auth, children}) => {
        if (!auth) {
            return <Navigate to='/profile' replace/>;
        }
        return children;
    };

    useEffect(() => {
        isAuth()
            .then((r) => {
                setAuth(r);
            })
            .catch(() => {
                localStorage.clear();
            });
    }, []);

    return (
        <>
            <NavigationComponent auth={auth}/>
            <Routes>
                <Route path='/' element={<HomeComponent/>}/>
                <Route path='/menu' element={<MenuComponent auth={auth}/>}/>
                <Route path='/contact' element={<ContactComponent/>}/>

                <Route
                    path='/signup'
                    element={
                        <ProtectedRouteForAuth auth={!auth}>
                            <SignUpComponent/>
                        </ProtectedRouteForAuth>
                    }
                />
                <Route
                    path='/login'
                    element={
                        <ProtectedRouteForAuth auth={!auth}>
                            <LogInComponent/>
                        </ProtectedRouteForAuth>
                    }
                />
                <Route
                    path='/profile'
                    element={
                        <ProtectedRoute auth={auth}>
                            <ProfileComponent/>
                        </ProtectedRoute>
                    }
                />
            </Routes>
        </>
    );
};

export default App;
