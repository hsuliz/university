import express, {NextFunction, Request, Response} from 'express';
import {User} from '../../../model/user';


const router = express.Router();

router.post(
    '/api/users/signup',
    async (req: Request, res: Response, next: NextFunction) => {
        const {username, password} = req.body;
        const existingUser = await User.findOne({username});

        if (existingUser) {
            return res.status(202).send('Username in use!!');
        }

        const user = new User({
            username,
            password,
        });
        await user.save();

        return res.status(201).send('Created!!');
    }
);

export {router as signupRouter};
