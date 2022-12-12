import {model, Schema} from 'mongoose';

interface IUser {
    price: string;
}

// 2. Create a Schema corresponding to the document interface.
const userSchema = new Schema<IUser>({
    price: {type: String, required: true},
});

// 3. Create a Model.
const Order = model<IUser>('Order', userSchema);

export {Order};
