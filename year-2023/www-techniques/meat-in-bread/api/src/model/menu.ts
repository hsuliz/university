import {model, Schema} from "mongoose";

export interface IMenu {
    name: string;
    price: number;
    vegan: boolean;
}

const menySchema = new Schema<IMenu>({
        name: String,
        price: Number,
        vegan: "Boolean"
    },
    {
        toJSON: {
            transform(doc, ret) {
                delete ret.__v;
            }
        }
    });

const Menu = model<IMenu>('Menu', menySchema);

export {Menu};
