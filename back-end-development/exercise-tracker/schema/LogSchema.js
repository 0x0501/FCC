import { Schema } from "mongoose";
import { LogInfoSchema, LogInfoStruct } from "./LogInfoSchema";
/**
 * @typedef LogStruct
 * @property {string} username
 * @property {number} count
 * @property {Array<LogInfoStruct>} log
 */

/**@type {LogStruct} */
const LogStruct = {};

const LogSchema = Schema({
	username: String,
	count: Number,
	log: [LogInfoSchema],
});

export { LogStruct, LogSchema };
