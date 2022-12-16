import axios from "axios";


const API_URL = 'http://localhost:3001/api/menu';

const readMenu = () => {
    return axios.get(
        API_URL
    );
}

export {readMenu};
