import { Schema } from "mongoose";
/**
 * @typedef ExerciseStruct
 * @property {string} username
 * @property {string} description
 * @property {number} duration
 * @property {string} date
 * @property {string} _id
 */

/**@type {ExerciseStruct} */
const ExerciseStruct = {};

/**@type {Schema<ExerciseStruct>} */
const ExerciseSchema = Schema({
	username: String,
	description: String,
	duration: Number,
	date : String
});

export { ExerciseStruct, ExerciseSchema };
