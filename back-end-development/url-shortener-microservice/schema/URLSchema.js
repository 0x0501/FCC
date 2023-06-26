import { Schema } from "mongoose";

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
