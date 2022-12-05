import express, {Express} from 'express';
import * as mongoose from "mongoose";
import authorRoutes from './route/test-route';

const DB_URI: string = "mongodb://localhost:27017/meat?authSource=admin"
const PORT_NUMBER: number = 3000;
const app: Express = express();
let db: mongoose.Connection;

// server
app
    .use(express.json())
    .use(express.urlencoded({extended: true}))
    .use("/get", authorRoutes)
    .listen(PORT_NUMBER, () => {
        console.log(`⚡️[server]: Server is running at https://localhost:${PORT_NUMBER} ${process.env.DB_HOST}`);
    });

// connect to db
mongoose
    .connect(DB_URI, {
        user: "meat",
        pass: "meat"
    })
    .then(() => {
        console.log("Connected to db!!")
        db = mongoose.connection;
    })
    .catch((e: Error) => {
        console.log(e)
    })


