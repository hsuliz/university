import mongoose from 'mongoose';
import {Password} from '../service/password';


interface UserAttrs {
    username: String,
    password: string
}

interface UserModel extends mongoose.Model<UserDoc> {
    build(attrs: UserAttrs): UserDoc;
}

interface UserDoc extends mongoose.Document {
    username: string,
    password: string
}

const user = new mongoose.Schema({
    username: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true
    }
}, {
    toJSON: {
        transform(doc, ret) {
            ret.id = ret._id;
            delete ret._id;
            delete ret.password;
            delete ret.__v;
        }
        /*transform(doc, ret) {
            ret.id = ret._id,
                delete ret._id,
                delete ret.password,
                delete ret.__v
        }*/
    }
});

user.pre('save', async function (done) {
    if (this.isModified('password')) {
        const hashed = Password.toHash(this.get('password'));
        this.set('password', hashed);
    }
});

user.statics.build = (attrs: UserAttrs) => {
    return new User(attrs);
};

const User = mongoose.model<UserDoc, UserModel>('User', user);
export {User};
