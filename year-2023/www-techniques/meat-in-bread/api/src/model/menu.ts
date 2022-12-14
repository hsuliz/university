import {model, Schema} from "mongoose";

interface IMenu {
    name: String;
    price: String;
    vegan: boolean;
}

const menySchema = new Schema<IMenu>({
        name: String,
        price: String,
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
