import express, {NextFunction, Request, Response} from 'express';
import {Order} from "../../model/order";

const router = express.Router();

router.post(
    '/api/order',
    async (req: Request, res: Response, next: NextFunction) => {
        const price = req.body.price;

        console.log(price);
        const order = new Order({
            price: price
        });
        await order.save();
        res.status(200).send(price.stringify);
    }
);

export {router as orderAdd};
