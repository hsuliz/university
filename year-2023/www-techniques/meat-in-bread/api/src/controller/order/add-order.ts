import express, {NextFunction, Request, Response} from 'express';
import {verification} from "../../service/auth-service";
import {User} from "../../model/user";

const router = express.Router();

router.post(
    '/api/orders',
    async (req: Request, res: Response, next: NextFunction) => {
        const user = await verification(req, next);
        const {name, price} = req.body;


        res.status(200).send(user);
    }
);

export {router as orderCreate};
