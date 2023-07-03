(function (Form) {
	const responseArea = document.querySelector(".result");
	const responseInfo = document.querySelector(".result p");

	Form.addEventListener("submit", env => {
		env.preventDefault();

		/**@type {FormData} */
		const formData = new FormData(Form);

		fetch("/api/fileanalyse", {
			method: "POST",
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
