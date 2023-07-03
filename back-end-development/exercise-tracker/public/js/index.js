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
		ADD_USER: "/api/users",
		ADD_EXERCISE: user_id => `/api/users/${user_id}/exercises`,
		GET_LOGS: user_id => `/api/users/${user_id}/logs`,
	};
	const responseWrapper = document.querySelector(".result");
	const responseArea = document.querySelector(".response");

	Forms.userForm.addEventListener("submit", env => {
		env.preventDefault();
		const username = new FormData(env.target).get("username");
		fetch(API.ADD_USER, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				username,
			}),
		})
			.then(res => res.json())
			.then(data => {
				responseWrapper.classList.remove("hidden");
				responseArea.textContent = JSON.stringify(data);
			})
			.catch(err => console.error(err));
	});

	Forms.exerciseForm.addEventListener("submit", env => {
		env.preventDefault();
		const formData = new FormData(env.target);
		const userID = formData.get("user_id");
		const description = formData.get("desc");
		const duration = formData.get("duration");
		const submit_date = formData.get("exercise_date");

		fetch(API.ADD_EXERCISE(userID), {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				user_id: userID,
				desc: description,
				duration: duration,
				date: submit_date,
			}),
		})
			.then(res => res.json())
			.then(data => {
				responseWrapper.classList.remove("hidden");
				responseArea.textContent = JSON.stringify(data);
			})
			.catch(err => console.error(err));
	});

	Forms.logForm.addEventListener("submit", env => {
		env.preventDefault();

		const formData = new FormData(env.target);
		const userID = formData.get("user_id");
		const fromTimeThen = formData.get("date_from");
		const toTimeThen = formData.get("date_to");
		const limitation = formData.get("limit");

		const builder = new URLSearchParams();

		if (fromTimeThen !== "") {
			builder.set("from", fromTimeThen);
		}

		if (toTimeThen !== "") {
			builder.set("to", toTimeThen);
		}

		if (limitation !== "") {
			builder.set("limit", limitation);
		}

		const requestURL =
			API.GET_LOGS(userID) +
			(builder.toString() === "" ? "" : "?" + builder.toString());

		fetch(requestURL)
			.then(res => res.json())
			.then(data => {
				responseWrapper.classList.remove("hidden");
				responseArea.textContent = JSON.stringify(data);
			})
			.catch(err => console.error(err));
	});
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
