import jwt from 'jsonwebtoken';
import {Request, Response} from 'express';
import {User} from '../model/user';

interface JwtPayload {
    id: string
}

export const verification = async (req: Request, res: Response) => {

    if (!req.headers.authorization?.startsWith('Bearer ')) {
        res.status(202).send('Its not a bearer token');
        return;
    }

    const token = req.headers.authorization.substring(7, req.headers.authorization?.length);
    let user;
    console.log(token)
    try {
        user = jwt.verify(token, process.env.JWT_SECRET!) as JwtPayload;
    } catch (e: any) {
        console.log(e);
        res.status(202).send('Invalid token or expired!!');
        return;
    }

    return User.findById(user?.id);

};