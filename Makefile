build:
	docker build -t dockervim .

run:
	docker run -ti -p 2015:2015 --rm dockervim /bin/bash
