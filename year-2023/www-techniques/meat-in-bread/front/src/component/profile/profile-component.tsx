import React from 'react';
import {Container, Table} from 'react-bootstrap';

const ProfileComponent: React.FC = () => {

    // @ts-ignore
    const user = JSON.parse(localStorage.getItem('user'));

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
                                <th>Name</th>
                                <th>Price</th>
                                <th>Type</th>
                            </tr>
                            </thead>
                            <tbody>
                            {user.orders.map(m =>
                                <tr key={m._id}>
                                    <td>{m.name}</td>
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
