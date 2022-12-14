import express, {NextFunction, Request, Response} from 'express';
import {verification} from "../../service/auth-service";


const router = express.Router();

router.get('/api/users',
    async (req: Request, res: Response, next: NextFunction) => {
        const user = await verification(req, next);

        await user?.update({$push: {orders: {name: "Food", price: "23"}}})

        res.status(200).send(user);
    });

export {router as infoRouter};
