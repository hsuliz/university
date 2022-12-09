import {Schema} from "mongoose";

const mongoose = require("mongoose");

type TUser = {
    username: string,
    password: string,
};

const UserSchema = new Schema<TUser>({
    username: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
        min: 6,
    },
}, {timestamps: true});

module.exports = mongoose.model("User", UserSchema);
