import React from "react";
import Container from "react-bootstrap/Container";
import {ErrorMessage, Field, Form, Formik} from "formik";
import {TUser} from "../type/user-type";
import {registerUser} from "../service/user-auth";

const LoginComponent: React.FC = () => {

    const initialValues: TUser = {password: "", username: ""}

    const handleRegister = (user: TUser) => {
        registerUser(user)
            .then((data) => {
                console.log(data);
            })
            .catch(() => {
                console.log("Error");
            })
    };

    return (
        <Container>
            <div className="col-md-12">
                <div className="card card-container">
                    <Formik
                        initialValues={initialValues}
                        onSubmit={handleRegister}
                    >
                        <Form>
                            <h1>Log in</h1>
                            <div className="form-group">
                                <label htmlFor="username">Username</label>
                                <Field name="username" type="text" className="form-control"/>
                                <ErrorMessage
                                    name="username"
                                    component="div"
                                    className="alert alert-danger"
                                />
                            </div>

                            <div className="form-group">
                                <label htmlFor="password">Password</label>
                                <Field name="password" type="password" className="form-control"/>
                                <ErrorMessage
                                    name="password"
                                    component="div"
                                    className="alert alert-danger"
                                />
                            </div>
                            <p></p>
                            <div className="form-group">
                                <button type="submit" className="btn btn-primary btn-block">
                                    <span>Login</span>
                                </button>
                            </div>
                        </Form>
                    </Formik>
                </div>
            </div>
        </Container>
    );
};

export default LoginComponent;
