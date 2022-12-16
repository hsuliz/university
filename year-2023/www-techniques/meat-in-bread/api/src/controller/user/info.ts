import express, {NextFunction, Request, Response} from 'express';
import {verification} from '../../service/auth-service';


const router = express.Router();

router.get('/api/users',
    async (req: Request, res: Response, next: NextFunction) => {
        const user = await verification(req, res);
        if (user) {
            res.status(200).send(user);
        }
    });

export {router as infoRouter};
