import { Schema } from "mongoose";
/**
 * @typedef ExerciseStruct
 * @property {string} username
 * @property {string} description
 * @property {number} duration
 */

/**@type {ExerciseStruct} */
const ExerciseStruct = {};

/**@type {Schema<ExerciseStruct>} */
const ExerciseSchema = Schema({
	username: String,
	description: String,
	duration: Number,
});

export { ExerciseStruct, ExerciseSchema };
