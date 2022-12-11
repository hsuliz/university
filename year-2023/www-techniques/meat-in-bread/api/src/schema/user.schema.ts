import {model, Schema,} from 'mongoose';
import {UserType} from "../type/user.type";

const userSchema = new Schema<UserType>({
    username: {type: String, required: true},
    password: {type: String, required: true},
});


export const User = model<UserType>("User", userSchema);
