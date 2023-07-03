import mongoose from "mongoose";
import 'dotenv/config';

export default await mongoose.connect(process.env['MONGO_URI']);
