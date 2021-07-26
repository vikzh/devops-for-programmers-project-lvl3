plan:
	make -C terraform plan
apply:
	make -C terraform apply
deploy:
	make -C ansible deploy
galaxy-install:
    make -C ansible galaxy-install