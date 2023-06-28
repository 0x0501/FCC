/**@type {HTMLFormElement} */
const form = document.querySelector(".panel form");
form.addEventListener("submit", env => {
	env.preventDefault();
	SuccessPanel.unmount();
	/**@type {string} */
	const url = new FormData(env.target).get("url");
	fetch("/api/shorturl/", {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({
			url: url,
		}),
	})
		.then(data => data.json())
		.then(response => {
			// response { original_url: "[URL]", short_url: [identity] }
			// or { error: "invalid url" }
			if (response.error === undefined) {
				SuccessPanel.mount(response);
			} else {
				ErrorDialog.display(response.error);
			}
		})
		.catch(err => {
			console.error(err);
		});
});

const SuccessPanel = (() => {
	function unmount() {
		const responseArea = document.querySelector(".responseArea.view");
		responseArea.classList.add("hidden");
	}

	function mount(response) {
		const responseArea = document.querySelector(".responseArea.view");

		let elementWrapper = null;
		let elementShortLink = null;

		/**
		 * first time load
		 */
		if (responseArea.children.length === 0) {
			elementWrapper = document.createElement("p");
			elementShortLink = document.createElement("a");
		} else {
			elementWrapper = document.querySelector(".responseArea.view p");
			elementShortLink = document.querySelector(".responseArea.view a");
		}

		elementWrapper.innerText = "The short url is: ";
		elementShortLink.href = `${document.URL}api/shorturl/${response.short_url}`;
		elementShortLink.innerText = `${document.URL}api/shorturl/${response.short_url}`;
		elementShortLink.target = "_blank";

		elementWrapper.appendChild(elementShortLink);
		responseArea.appendChild(elementWrapper);
		responseArea.classList.remove("hidden");
	}

	return {
		mount,
		unmount,
	};
})();
const ErrorDialog = (() => {
	const root = document.createElement("div");
	root.classList.add("dialog", "view");

	const header = document.createElement("span");
	header.textContent = "Error";

	const text = document.createElement("p");

	function display(content) {
		text.textContent = content;
		root.appendChild(header);
		root.appendChild(text);
		document.body.appendChild(root);

		new Promise(resolve => {
			setTimeout(() => {
				root.classList.add("show");
				resolve();
			}, 10);
		})
			.then(() => {
				return new Promise((resolve, reject) => {
					setTimeout(() => {
						root.classList.remove("show");
						resolve();
					}, 2000);
				});
			})
			.then(() => {
				setTimeout(() => {
					root.remove();
				}, 300);
			});
	}

	return {
		display,
	};
})();
