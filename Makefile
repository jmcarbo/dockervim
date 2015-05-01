build:
	docker build -t dockervim .

run:
	docker run -ti --rm dockervim /bin/bash
