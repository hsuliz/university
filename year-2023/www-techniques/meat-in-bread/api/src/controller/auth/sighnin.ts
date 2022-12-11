import express, {NextFunction, Request, Response} from 'express';
import jwt from 'jsonwebtoken'

import {User} from '../../model/user';
import {Password} from "../../service/password";


const router = express.Router();

router.post('/api/users/signin',
    async (req: Request, res: Response, next: NextFunction) => {
        const {email, password} = req.body;

        // Get user
        const existingUser = await User.findOne({email});
        if (!existingUser) {
            return next(new Error('Invalid credential'));
        }

        // Check the Passsword
        const passwordMatch = Password.compare(existingUser.password, password);
        if (!passwordMatch) {
            return next(new Error('Invalid credential'));
        }

        // Generate JWT
        const userJwt = jwt.sign({
            id: existingUser.id,
            email: existingUser.username
        }, process.env.JWT_SECRET!);

        res.status(200).send({token: userJwt})

    });

export {router as signinRouter};
