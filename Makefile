# because HCL files cannot reference the present working directory,
# this bit of gunk is necessary to dynamically generate a valid volume mount
nomad.job.hcl:
	cat nomad.job.hcl.dist | sed "s|%PWD%|$$(pwd)|" > nomad.job.hcl

nomad-up:
	tmux new-session -d -s "nomad" "nomad agent -dev -config ./nomad.config.hcl"

nomad-down:
# nomad does not gracefully exit when kill-session'd
	pkill nomad

nomad-run-job: nomad.job.hcl
	nomad run ./nomad.job.hcl

docker-build:
	docker build -t test:php .

service-info:
	@echo "Service is running at: " $$(nomad alloc status $$(nomad job status web | awk '/Allocations/,0' | awk 'NR > 2 {print $$1}') | grep http | awk '{print $$3}')
clean:
	rm ./nomad.job.hcl
