import React, {useState} from 'react';
import {Button} from 'react-bootstrap';


const ButtonComponent: React.FC = () => {

    const [counter, setCounter] = useState(0)

    const handleClick1 = () => {
        setCounter(counter + 1);
    }

    const handleClick2 = () => {
        setCounter(counter - 1);
    };

    return (
        <div>
            <Button onClick={handleClick2}>-</Button>
            {counter}
            <Button onClick={handleClick1}>+</Button>
        </div>
    );

};

export default ButtonComponent;
