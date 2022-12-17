import express, {NextFunction, Request, Response} from 'express';
import jwt from 'jsonwebtoken'

import {User} from '../../../model/user';


const router = express.Router();

router.post(
    '/api/users/login',
    async (req: Request, res: Response, next: NextFunction) => {

        const {username, password} = req.body;

        const existingUser = await User.findOne({username});
        if (!existingUser) {
            return next(new Error('Invalid username or password'));
        }

        const token = jwt.sign(
            {
                id: existingUser.id,
                username: existingUser.username,
            },
            process.env.JWT_SECRET!, {expiresIn: '30m'}
        );

        res.status(200).send(JSON.stringify(token));

    });

export {router as signinRouter};
