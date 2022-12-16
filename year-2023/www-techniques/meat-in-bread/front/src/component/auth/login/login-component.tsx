import {Card, Container} from 'react-bootstrap';
import React from 'react';
import './style.css';
import {Field, Form, Formik} from 'formik';


const LoginComponent: React.FC = () => {


    const initialValues = {
        password: '', username: ''
    };

    return (
        <Container>
            <Card>
                <h1>Log in</h1>
                <Formik
                    initialValues={initialValues}
                    onSubmit={(values, {setSubmitting}) => {
                        setTimeout(() => {
                            alert(JSON.stringify(values, null, 2));
                            setSubmitting(false);
                            window.location.reload();
                        }, 1000);
                    }}
                >
                    {({isSubmitting}) => (
                        <Form>
                            <Container className="form-group">
                                <label htmlFor="name">Name</label>
                                <Field name="name" className="form-control" type="text"/>
                            </Container>

                            <Container className="form-group">
                                <label htmlFor="email">Email Address</label>
                                <Field name="email" className="form-control" type="email"/>
                            </Container>

                            <Container className="form-group">
                                <label htmlFor="subject">Subject</label>
                                <Field name="subject" className="form-control" type="text"/>
                            </Container>

                            <Container className="form-group">
                                <label htmlFor="content">Content</label>
                                <Field name="content" className="form-control" as="textarea"/>
                            </Container>
                            <Container className="form-group">
                                <button type="submit" className="btn btn-primary"
                                        disabled={isSubmitting}>{isSubmitting ? 'Please wait...' : 'Submit'}</button>
                            </Container>
                        </Form>
                    )}
                </Formik>
            </Card>

        </Container>
    );

};

export default LoginComponent;
