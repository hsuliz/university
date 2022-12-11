import express, {Express} from 'express';
import * as mongoose from "mongoose";
import 'dotenv/config'


const app: Express = express();
// server
app
    .use(express.json())
    .use(express.urlencoded({extended: true}))
    .listen(
        process.env.PORT,
        () => console.log(`[server]: Server is running at https://localhost:${process.env.PORT}!!`)
    );

// connect to db
mongoose.connect(process.env.DB_URI!, {
    user: process.env.DB_USER,
    pass: process.env.DB_PASS
})
    .then(async () => {
        console.log("[server]: Connected to db!!")
    })
    .catch((e: Error) => {
        console.log(e)
    })
