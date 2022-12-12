import express, {NextFunction, Request, Response} from 'express';
import jwt from 'jsonwebtoken'


const router = express.Router();

router.get('/api/users',
    async (req: Request, res: Response, next: NextFunction) => {
        console.log(req.headers.authorization);
    });

export {router as infoRouter};
