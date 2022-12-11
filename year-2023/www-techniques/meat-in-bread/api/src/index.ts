import express, {Express} from 'express';
import * as mongoose from 'mongoose';
import 'dotenv/config';
import {json} from "body-parser";
import {signupRouter} from "./controller/auth/sighnup";


const app: Express = express();

app.use(json());
`/*app.use(signinRouter);*/`
app.use(signupRouter);

// Connecting to Mongodb
const initializeConfig = async () => {
    try {
        await mongoose.connect(process.env.DB_URI!, {
            user: process.env.DB_USER,
            pass: process.env.DB_PASS
        })
        console.log('[server]: Connected to mongo db.')
    } catch (error) {
        console.log(error)
    }
};

app.listen(process.env.PORT, async () => {
    await initializeConfig();
    console.log(`[server]: Server is running at http://localhost:${process.env.PORT}.`);
});
