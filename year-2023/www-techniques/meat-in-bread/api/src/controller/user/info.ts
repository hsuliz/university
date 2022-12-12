import express, {NextFunction, Request, Response} from 'express';
import jwt from 'jsonwebtoken'

import {User} from "../../model/user";


const router = express.Router();

router.get('/api/users',
    async (req: Request, res: Response, next: NextFunction) => {
        if (!req.headers.authorization?.startsWith('Bearer ')) {
            return next(new Error('No bearer token!!'));
        }

        const token = req.headers.authorization.substring(7, req.headers.authorization?.length);
        let tokenUser;

        try {
            tokenUser = jwt.verify(token, process.env.JWT_SECRET!)
        } catch (e: any) {
            return next(new Error('Invalid token!!'));
        }

        const existingUser = await User.findOne({tokenUser})

        res.status(200).send(existingUser)
    });

export {router as infoRouter};
