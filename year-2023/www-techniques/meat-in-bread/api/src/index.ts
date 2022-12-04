import express, {Express, Request, Response} from 'express';
import * as mongoose from "mongoose";
import {User} from "./model/user";


const PORT_NUMBER: number = 3000;
const app: Express = express();
let db: mongoose.Connection;


app.get('/test', (req: Request, res: Response) => {
    res.json({message: "test"});
});

mongoose
    .connect("mongodb://localhost:27017/meat?authSource=admin", {
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

async function run() {
    const user = await User.create({email: "Sasha", name: "sasha"})
}

app.listen(PORT_NUMBER, () => {
    console.log(`⚡️[server]: Server is running at https://localhost:${PORT_NUMBER}`);
});

run()

