import express, {Express, NextFunction, Request, Response} from 'express';
import mongoose from 'mongoose';
import 'dotenv/config';
import {json} from "body-parser";
import {signupRouter} from "./controller/auth/sighnup";
import {signinRouter} from "./controller/auth/sighnin";
import {infoRouter} from "./controller/info";


const app: Express = express();

app.use(json());
app.use(infoRouter);
app.use(signinRouter);
app.use(signupRouter);

app.all('*', async (req: Request, res: Response, next: NextFunction) => {
    return next(new Error('Invalid route'));
})

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    res.json({
        message: err.message || "an unknown error occurred!",
    });
});


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
