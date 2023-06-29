import { Schema } from "mongoose";

/**
 * @typedef UserStruct
 * @property {string} username
 */

/**@type {UserStruct} */
const UserStruct = {};

/**@type {Schema<UserStruct>} */
const UserSchema = Schema({
	username: String,
});

export { UserStruct, UserSchema };
