import express, {NextFunction, Request, Response} from 'express';


const router = express.Router();

router.get('/api/users',
    async (req: Request, res: Response, next: NextFunction) => {
        console.log(req.body.authorization);
    });

export {router as infoRouter};
