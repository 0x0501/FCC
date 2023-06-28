import mongoose from "mongoose";
import "dotenv/config";

const DB = mongoose.connect(process.env['MONGO_URI']);

export default DB;