(function (Form) {
	/**@type {FormData} */
	const formData = new FormData(Form);

	const responseArea = document.querySelector(".result");
	const responseInfo = document.querySelector(".result p");

	Form.addEventListener("submit", env => {
		env.preventDefault();

		fetch("/api/upload", {
			method: "POST",
			headers: {
				"Content-Type": "multipart/form-data",
			},
			body: formData,
		})
			.then(data => data.json())
			.then(res => {
				responseInfo.textContent = JSON.stringify(res);
				responseArea.classList.remove("hidden");
			})
			.catch(err => console.error(err));
	});
})(document.querySelector(".wrapper form"));
