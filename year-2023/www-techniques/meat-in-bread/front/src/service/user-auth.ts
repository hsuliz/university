import axios from 'axios';
import {TUser} from '../type/user-type';
import authHeader from './auth-header';

const API_URL = 'http://localhost:3001/api/users';

const userSignUp = (user: TUser) => {
    return axios.post(
        API_URL + '/signup',
        {
            username: user.username,
            password: user.password
        }
    );
};

const userLogIn = (user: TUser) => {
    return axios.post(
        API_URL + '/login',
        {
            username: user.username,
            password: user.password
        }
    );
};

const isAuth = async () => {
    const response = await axios.get(
        API_URL, {headers: authHeader()}
    )
    return response.status === 200;
};


export {userSignUp, userLogIn, isAuth};
