import { Schema } from "mongoose";

/**
 * @typedef UserStruct
 * @property {string} username
 * @property {string} _id
 */

/**@type {UserStruct} */
const UserStruct = {};

/**@type {Schema<UserStruct>} */
const UserSchema = Schema({
	username: String,
});

export { UserStruct, UserSchema };
