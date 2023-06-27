/**@type {HTMLFormElement} */
const form = document.querySelector(".panel form");
form.addEventListener("submit", env => {
	env.preventDefault();

	/**@type {string} */
	const url = new FormData(env.target).get("url");
	fetch("/api/shorturl/", {
		method: "POST",
		body: JSON.stringify({
            url : url
        })
	})
		.then(data => data.json())
		.then(response => {
            console.log(response)
        })
		.catch(err => {
			console.error(err);
		});
});
