import {Button, Card, Container} from 'react-bootstrap';
import React, {useState} from 'react';
import './style.css';
import {Field, Form, Formik} from 'formik';
import {TUser} from '../../../type/user-type';
import {registerUser} from '../../../service/user-auth';


const LoginComponent: React.FC = () => {

    const [valid, setValid] = useState<boolean>(false);

    const initialValues: TUser = {
        password: '', username: ''
    };

    const submitLogIn = (data: TUser) => {
        registerUser(data)
            .then((r) => {
                console.log(data);
                console.log(r);
            })
    }

    return (
        <Container>
            <Card>
                <h1>Log in</h1>
                <Formik
                    initialValues={initialValues}
                    onSubmit={(values) => {
                        submitLogIn(values);
                        alert(JSON.stringify(values, null, 2));
                    }}
                >
                    <Form>
                        <Container className="form-group">
                            <label htmlFor="username">Username</label>
                            <Field name="username" className="form-control" type="text"/>
                        </Container>
                        <Container className="form-group">
                            <label htmlFor="password">Password</label>
                            <Field name="password" className="form-control" type="password"/>
                        </Container>
                        <br/>
                        <Container className="form-group">
                            <Button type="submit" className="btn btn-primary">
                                Log in!
                            </Button>
                        </Container>
                        <br/>
                    </Form>
                </Formik>
            </Card>
        </Container>
    );

};

export default LoginComponent;
