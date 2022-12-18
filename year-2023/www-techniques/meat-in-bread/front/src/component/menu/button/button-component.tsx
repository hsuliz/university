import React, {useState} from 'react';
import {Button, ButtonGroup} from 'react-bootstrap';

interface IProps {
    addItemOrder: any;
    removeItemOrder: any;
    orderId: string;
}

const ButtonComponent: React.FC<IProps> = ({addItemOrder, removeItemOrder, orderId}) => {

    const [counter, setCounter] = useState(0)

    const handleClickPlus = () => {
        if (counter === 9) {
            return;
        }
        setCounter(counter + 1);
        addItemOrder(orderId);
    }

    const handleClickMinus = () => {
        if (counter === 0) {
            return;
        }
        setCounter(counter - 1);
        removeItemOrder(orderId);
    };

    return (
        <div className='d-flex flex-column'>
            <ButtonGroup size='sm'>
                <Button variant='light' size='sm' className='custom-btn' onClick={handleClickMinus}>-</Button>
                <span className='text-center'>{counter}</span>
                <Button variant='light' size='sm' className='custom-btn' onClick={handleClickPlus}>+</Button>
            </ButtonGroup>
        </div>
    );

};

export default ButtonComponent;
