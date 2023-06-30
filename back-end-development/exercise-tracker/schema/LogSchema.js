import { Schema } from "mongoose";
import { LogInfoSchema, LogInfoStruct } from "./LogInfoSchema.js";
/**
 * @typedef LogStruct
 * @property {string} username
 * @property {number} count
 * @property {Array<LogInfoStruct>} log
 * @property {string} _id
 */

/**@type {LogStruct} */
const LogStruct = {};

const LogSchema = Schema({
	username: String,
	count: Number,
	log: [LogInfoSchema],
});

export { LogStruct, LogSchema };
