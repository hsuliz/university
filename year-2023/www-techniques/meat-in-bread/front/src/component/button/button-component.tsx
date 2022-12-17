import React, {useState} from 'react';
import {Button} from 'react-bootstrap';

interface IProps {
    addItemOrder: any;
    removeItemOrder: any;
    orderId: string;
}

const ButtonComponent: React.FC<IProps> = ({addItemOrder, removeItemOrder, orderId}) => {

    const [counter, setCounter] = useState(0)

    const handleClickPlus = () => {
        setCounter(counter + 1);
        addItemOrder(orderId);
    }

    const handleClickMinus = () => {
        setCounter(counter - 1);
        removeItemOrder(orderId);
    };

    return (
        <div>
            <Button onClick={handleClickMinus}>-</Button>
            {counter}
            <Button onClick={handleClickPlus}>+</Button>
        </div>
    );

};

export default ButtonComponent;
