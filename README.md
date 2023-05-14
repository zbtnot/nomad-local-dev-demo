nomad-local-demo
================

A sample repository demonstrating how to leverage nomad for local development via docker.
The motivation for doing this as opposed to docker-compose is that nomad is closer to what a production environment might look like.

How to use this demo
--------------------
- Install `nomad`, `docker` and `tmux`
- From the project directory, run in order:
  - `make docker-build`
  - `make nomad-up` 
  - `make nomad-run-job`
- If everything succeeded, `make service-info` should display the port the container is listening on.

Thoughts
--------
This kinda works, but there are limitations:
- Nomad's HCL does not allow you to specify a relative path from the job command, hence the wonky distfile for the job
  - There are other ways to [mount into the container](https://developer.hashicorp.com/nomad/tutorials/stateful-workloads/stateful-workloads), but these are also overkill for development.
- You need to specify additional configuration to enable docker's mounting feature.
  - For production, you may not need this; Ideally your container images would include your application code.
  - That said, it is incredibly handy for iterating during the development process. No need to rebuild every time you make a change.