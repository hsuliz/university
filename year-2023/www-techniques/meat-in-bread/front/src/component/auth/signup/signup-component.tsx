import {Button, Card, Container} from 'react-bootstrap';
import React from 'react';
import '../style.css';
import {Field, Form, Formik} from 'formik';
import {TUser} from '../../../type/user-type';
import {userSignUp} from '../../../service/user-auth';


const SignUpComponent: React.FC = () => {

    const initialValues: TUser = {
        password: '', username: ''
    };

    const submitSignUp = (data: TUser) => {
        userSignUp(data)
            .then((r) => {
                console.log(data);
                console.log(r);
                window.location.reload();
            });
    };

    return (
        <Container>
            <Card>
                <h1>Sign Up</h1>
                <Formik
                    initialValues={initialValues}
                    onSubmit={(values) => submitSignUp(values)}
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
                                Sign up!
                            </Button>
                        </Container>
                        <br/>
                    </Form>
                </Formik>
            </Card>
        </Container>
    );

};

export default SignUpComponent;
