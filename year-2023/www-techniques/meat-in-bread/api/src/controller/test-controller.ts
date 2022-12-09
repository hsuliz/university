import express, {NextFunction, Request, Response} from "express";
const app = express.Router();

const readTest = (req: Request, res: Response, next: NextFunction) => {
    res.status(200)
};


export default {readTest};
