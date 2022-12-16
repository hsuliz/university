import React, {useState} from "react";
import Container from "react-bootstrap/Container";
import {ErrorMessage, Field, Form, Formik} from "formik";
import {TUser} from "../type/user-type";
import {registerUser} from "../service/user-auth";
import {redirect} from "react-router-dom";

const SignupComponent: React.FC = () => {

    const initialValues: TUser = {password: "", username: ""}
    const [errorMessage, setErrorMessage] = useState("");


    const handleRegister = (user: TUser) => {
        registerUser(user)
            .then((data) => {
                if (data.status === 202) {
                    setErrorMessage(data.data);
                } else {
                    console.log("here");
                    redirect("/api/menu");
                }
            })
            .catch(() => {
                console.log("Error");
            });
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
                    {errorMessage &&
                        <Container>
                            {errorMessage}
                        </Container>
                    }
                </div>
            </div>
        </Container>
    );
};

export default SignupComponent;
