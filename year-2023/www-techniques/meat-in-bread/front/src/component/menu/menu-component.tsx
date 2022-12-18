import React, {useEffect, useState} from 'react';
import {TMenu} from '../../type/menu-type';
import {readMenu} from '../../service/menu-service';
import {Button, Container, Table} from 'react-bootstrap';
import ButtonComponent from './button/button-component';
import {sendOrder} from '../../service/user-auth';
import {useNavigate} from 'react-router-dom';

interface IProps {
    auth: boolean;
}

const MenuComponent: React.FC<IProps> = (props) => {

    const [menu, setMenu] = useState<Array<TMenu>>([]);
    const [order, setOrder] = useState<Array<string>>([]);
    let navigate = useNavigate();
    const aggroMap = new Map();

    const addItemOrder = (val) => {
        setOrder(oldOrders => [...oldOrders, val])
    };

    const removeItemOrder = (val) => {
        const array = [...order];
        const index = array.indexOf(val);
        if (index !== -1) {
            array.splice(index, 1);
            setOrder(array);
        }
    };

    useEffect(() => {
        readMenu()
            .then((response) => {
                setMenu(response.data);
            })
            .catch(() => {
                console.log('Error here');
            })
    }, []);

    const type = (x: boolean) => {
        if (x) {
            return '🌱';
        } else {
            return '🥩';
        }
    };

    const buttonOnClickOrder = () => {
        sendOrder(order)
            .then(() => {
                navigate('/profile');
                window.location.reload();
            });
    };

    const sumAggregator = () => {
        let sum = 0;
        aggroMap.forEach((value) => {
            sum += value;
        });
        return sum;
    };

    const aggregator = (m) => {
        aggroMap.set(m._id, (order.filter(o => o.includes(m._id))).length * m.price);
        return (order.filter(o => o.includes(m._id))).length * m.price;
    };

    return (
        <Container fluid='lg'>
            <h1 className='text-center'>Menu</h1>
            <Table striped bordered responsive='sm' size='sm'>
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Type</th>
                    {
                        props.auth &&
                        <>
                            <th>Quantity</th>
                            <th>Summary</th>
                        </>
                    }
                </tr>
                </thead>
                <tbody>
                {menu.map(m =>
                    <tr key={m._id}>
                        <td>{m.name}</td>
                        <td>{m.price}</td>
                        <td>{type(m.vegan)}</td>
                        {
                            props.auth &&
                            <>
                                <td><ButtonComponent
                                    addItemOrder={addItemOrder}
                                    removeItemOrder={removeItemOrder}
                                    orderId={m._id}
                                /></td>
                                <td><span className='price-table'>{aggregator(m)}</span></td>
                            </>
                        }
                    </tr>)}
                </tbody>
            </Table>
            {props.auth &&
                <div>
                    <div>Total price:</div>
                    <div>{sumAggregator()}</div>
                    <br/>
                    <Button
                        onClick={buttonOnClickOrder}
                        disabled={sumAggregator() === 0}
                    >Order!!
                    </Button>
                </div>
            }
        </Container>
    );

};

export default MenuComponent;
