import axios from 'axios';


const readMenu = () => {
    return axios.get(
        'http://localhost:3001/api/menu'
    );
}

export {readMenu};
