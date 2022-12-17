import React from 'react';
import {Container, Table} from 'react-bootstrap';

const ProfileComponent: React.FC = () => {

    // @ts-ignore
    const user = JSON.parse(localStorage.getItem('user'));


    const dateParser = (date) => {
        date = new Date(date);

        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let dt = date.getDate();

        if (dt < 10) {
            dt = '0' + dt;
        }
        if (month < 10) {
            month = '0' + month;
        }

        return (dt + '-' + month + '-' + year);
    };

    const listParser = (list) => {
        const count = {};
        list.forEach(x => {
            count[x] = (count[x] || 0) + 1;
        });
        console.log(count);
        return count;
    }

    return (
        <Container>
            <Container>
                <h1>Hi {user.username}</h1>
            </Container>
            {
                (user.orders.length > 0)
                    ? <Container><h2>Your orders:</h2>
                        <Table>
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Order</th>
                                <th>Price</th>
                            </tr>
                            </thead>
                            <tbody>
                            {user.orders.reverse().map(m =>
                                <tr key={m._id}>
                                    <td>{dateParser(m.createdAt)}</td>
                                    <td>{
                                        Object.keys(listParser(m.list)).map((keyName, i) => (
                                            <li key={i}>
                                                {keyName}{' '}x{listParser(m.list)[keyName]}
                                            </li>
                                        ))
                                    }</td>
                                    <td>{m.price}</td>
                                </tr>)}
                            </tbody>
                        </Table>
                    </Container>
                    : <h2>Your order list is empty ;(</h2>
            }
        </Container>

    );
};

export default ProfileComponent;
