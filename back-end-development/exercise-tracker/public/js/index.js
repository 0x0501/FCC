/**
 * @typedef PageForms
 * @property {HTMLFormElement} userForm
 * @property {HTMLFormElement} exerciseForm
 * @property {HTMLFormElement} logForm
 */

/**
 * @param {PageForms} Forms
 */
(function (Forms) {

    const API = {
        ADD_USER : '/api/users',
        ADD_EXERCISE : (user_id) => `/api/users/${user_id}/exercises`,
        GET_LOGS : (user_id) => `/api/users/${user_id}/logs`
    }

    Forms.userForm.addEventListener('submit', env => {
        env.preventDefault();
        alert('1')
    });

    Forms.exerciseForm.addEventListener('submit', env => {
        env.preventDefault();
        alert('2')
    })

    Forms.logForm.addEventListener('submit', env => {
        env.preventDefault();
        alert('3')
    })
})(
	(() => {
		const query = document.querySelectorAll(".form-group");
		return {
			userForm: query[0],
			exerciseForm: query[1],
			logForm: query[2],
		};
	})()
);
