import React, {useState} from 'react';
import {Button, Card, Container} from 'react-bootstrap';
import {TUser} from '../../../type/user-type';
import {userLogIn} from '../../../service/user-auth';
import {Field, Form, Formik} from 'formik';

const LogInComponent: React.FC = () => {

    const [errorMessage, setErrorMessage] = useState<string>('');

    const initialValues: TUser = {
        password: '', username: ''
    };

    const submitLogIn = (data: TUser) => {
        userLogIn(data)
            .then((response) => {
                if (typeof response.data !== 'string') {
                    setErrorMessage(response.data.message);
                } else {
                    localStorage.setItem('token', response.data);
                    window.location.reload();
                }
            });
    };

    return (
        <Container>
            <Card>
                <h1>Log in</h1>
                <Formik
                    initialValues={initialValues}
                    onSubmit={(values) => submitLogIn(values)}
                >
                    <Form>
                        <Container className='form-group'>
                            <label htmlFor='username'>Username</label>
                            <Field name='username' className='form-control' type='text'/>
                        </Container>
                        <Container className='form-group'>
                            <label htmlFor='password'>Password</label>
                            <Field name='password' className='form-control' type='password'/>
                        </Container>
                        <br/>
                        <Container className='form-group'>
                            <Button type='submit' className='btn btn-primary'>
                                Log in!
                            </Button>
                        </Container>
                        <br/>
                    </Form>
                </Formik>
                {errorMessage &&
                    <div>{errorMessage}</div>}
            </Card>
        </Container>
    );


};

export default LogInComponent;
