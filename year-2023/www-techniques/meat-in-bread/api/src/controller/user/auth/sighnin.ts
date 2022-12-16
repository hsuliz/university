import express, {NextFunction, Request, Response} from 'express';
import jwt from 'jsonwebtoken'

import {User} from '../../../model/user';
import {Password} from '../../../service/password';


const router = express.Router();

router.post(
    '/api/users/login',
    async (req: Request, res: Response, next: NextFunction) => {
        const {username, password} = req.body;

        const existingUser = await User.findOne({username});
        if (!existingUser) {
            return next(new Error('Invalid username'));
        }

        const passwordMatch = Password.compare(existingUser.password, password);
        if (!passwordMatch) {
            return next(new Error('Invalid password'));
        }

        const token = jwt.sign(
            {
                id: existingUser.id,
                username: existingUser.username,
            },
            process.env.JWT_SECRET!, {expiresIn: '1h'}
        );

        res.status(200).send(JSON.stringify(token))
    });

export {router as signinRouter};
