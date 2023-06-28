import { Schema } from "mongoose";

/**
 * @typedef {Object} URLStruct
 * @property {string} original_url
 * @property {number} shorter_identity
 */

/**@type {URLStruct} */
const URLStruct = {};

/**
 * @type {Schema<{original_url : string, shorter_identity : number}>}
 */
export const URLSchema = Schema({
	original_url: String,
	shorter_identity: {
		type: Number,
		unique: true,
	},
});


export { URLStruct };
