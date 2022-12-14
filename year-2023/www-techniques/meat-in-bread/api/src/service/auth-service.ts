import jwt from "jsonwebtoken";
import {NextFunction, Request} from "express";
import {User} from "../model/user";

interface JwtPayload {
    id: string
}

export const verification = async (req: Request, next: NextFunction) => {
    if (!req.headers.authorization?.startsWith('Bearer ')) {
        return next(new Error('No bearer token!!'));
    }

    const token = req.headers.authorization.substring(7, req.headers.authorization?.length);
    let user;

    try {
        user = jwt.verify(token, process.env.JWT_SECRET!) as JwtPayload;
    } catch (e: any) {
        return next(new Error('Invalid token!!'));
    }

    return User.findById(user.id);
};
