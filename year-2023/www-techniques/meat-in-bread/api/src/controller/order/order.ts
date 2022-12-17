import express, {NextFunction, Request, Response} from 'express';
import {verification} from '../../service/auth-service';
import {IMenu, Menu} from '../../model/menu';


const router = express.Router();

router.post(
    '/api/orders',
    async (req: Request, res: Response, next: NextFunction) => {
        const user = await verification(req, res);
        const {list} = req.body;
        JSON.parse(JSON.stringify(list));
        const orders: any = [];
        let price = 0;
        for (const orderId of list) {
            const order: IMenu | any = await Menu.findById(orderId);
            price += order?.price;
            orders.push(order.name);
        }

        await user?.updateOne({$push: {orders: {list: orders, price}}});
        res.status(200).send(JSON.stringify('Added!!'));
    }
);

router.get(
    '/api/orders',
    async (req: Request, res: Response, next: NextFunction) => {
        const user = await verification(req, res);

        res.status(200).send(user?.get('orders'));
    }
);

export {router as ordersCRUD};
