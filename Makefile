build:
	docker build -t dockervim .

run:
	docker run -ti -p 2015:2015 -p 3000:3000 --rm dockervim /bin/bash
