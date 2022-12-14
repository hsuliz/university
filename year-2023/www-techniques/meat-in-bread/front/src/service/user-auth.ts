import axios from "axios";
import {TUser} from "../type/user-type";

const API_URL = "http://localhost:3001/api/users/signup/";

const registerUser = (user: TUser) => {
    return axios.post(
        API_URL,
        {
            username: user.username,
            password: user.password
        }
    );
};

export {registerUser};