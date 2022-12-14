import {model, Schema} from 'mongoose';
import {Password} from '../service/password';


interface IUser {
    username: String;
    password: string;
    orders: [];
}

interface IOrder {
    name: String;
    price: String;
}

const orderSchema = new Schema<IOrder>({
    name: String,
    price: String
});

const userSchema = new Schema<IUser>({
        username: {type: String, required: true},
        password: {type: String, required: true},
        orders: [orderSchema]
    },
    {
        toJSON: {
            transform(doc, ret) {
                delete ret.password;
                delete ret.__v;
            }
        }
    });

userSchema.pre('save', async function (done) {
    if (this.isModified('password')) {
        const hashed = Password.toHash(this.get('password'));
        this.set('password', hashed);
    }
});

const User = model<IUser>('User', userSchema);

export {User};
