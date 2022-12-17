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
        if(counter === 10) {
            return;
        }
        setCounter(counter + 1);
        addItemOrder(orderId);
    }

    const handleClickMinus = () => {
        if(counter === 0) {
            return;
        }
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
