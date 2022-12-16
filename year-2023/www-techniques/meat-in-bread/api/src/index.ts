import express, {Express, NextFunction, Request, Response} from 'express';
import mongoose from 'mongoose';
import 'dotenv/config';
import {json} from 'body-parser';

import {signinRouter} from './controller/user/auth/sighnin';
import {infoRouter} from './controller/user/info';
import {ordersCRUD} from './controller/order/order';
import {signupRouter} from './controller/user/auth/sighnup';
import {Menu} from './model/menu';
import {meatMenu} from './controller/menu/menu';
import cors from 'cors';

const app: Express = express();

app.use(json());
app.use(cors())

app.use(infoRouter);
app.use(signinRouter);
app.use(signupRouter);

app.use(ordersCRUD);
app.use(meatMenu);


app.all('*', async (req: Request, res: Response, next: NextFunction) => {
    return next(new Error('Invalid route'));
})

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    res.json({
        message: err.message || 'an unknown error occurred!',
    });
});


// Connecting to Mongodb
const initializeConfig = async () => {
    try {
        await mongoose.connect(process.env.DB_URI!, {
            user: process.env.DB_USER, pass: process.env.DB_PASS
        })
        console.log('[server]: Connected to mongo db.');

        // init meat in bread
        Menu.count({}, function (err, count) {
            if (count == 0) {
                Menu.insertMany([
                        {name: 'Chebureki', price: '12.50', vegan: false},
                        {name: 'Sarburma', price: '15.50', vegan: false},
                        {name: 'Börek', price: '8.50', vegan: true},
                        {name: 'Khachapuri', price: '10.00', vegan: true},
                        {name: 'Khabizgini', price: '12.00', vegan: true}
                    ]
                )
            }
        });

    } catch (error) {
        console.log(error);
    }
};

app.listen(process.env.PORT, async () => {
    await initializeConfig();
    console.log(`[server]: Server is running at http://localhost:${process.env.PORT}.`);
});
