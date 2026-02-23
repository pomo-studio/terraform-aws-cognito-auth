.PHONY: test fmt validate

test:
	terraform test

fmt:
	terraform fmt -recursive

validate:
	cd examples/basic && terraform init -backend=false -upgrade && terraform validate
	cd examples/complete && terraform init -backend=false -upgrade && terraform validate
