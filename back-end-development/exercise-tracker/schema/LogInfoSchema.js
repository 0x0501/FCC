import { Schema } from "mongoose";
/**
 * @typedef LogInfoStruct
 * @property {string} description
 * @property {number} duration
 * @property {string} date
 * @property {string} _id
 */

/**@type {LogInfoStruct} */
const LogInfoStruct = {};

/**@type {Schema<LogInfoStruct>} */
const LogInfoSchema = Schema({
	description: String,
	duration: Number,
	date: String,
});

export { LogInfoStruct, LogInfoSchema };
