import {Button, Card, Container} from 'react-bootstrap';
import React, {useState} from 'react';
import '../style.css';
import {Field, Form, Formik} from 'formik';
import {TUser} from '../../../type/user-type';
import {userSignUp} from '../../../service/user-auth';
import {useNavigate} from 'react-router-dom';


const SignUpComponent: React.FC = () => {

    let navigator = useNavigate();
    const [errorMessage, setErrorMessage] = useState<string>('');

    const initialValues: TUser = {
        password: '', username: ''
    };

    const submitSignUp = (data: TUser) => {
        userSignUp(data)
            .then((r) => {
                if (r.status === 202) {
                    setErrorMessage(r.data);
                    return
                }
                navigator('/login');
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
                                Sign up!
                            </Button>
                        </Container>
                        {
                            errorMessage &&
                            <div>{errorMessage}</div>
                        }
                        <br/>
                    </Form>
                </Formik>
            </Card>
        </Container>
    );

};

export default SignUpComponent;
