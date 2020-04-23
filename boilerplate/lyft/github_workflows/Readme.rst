Golang Github Actions
~~~~~~~~~~~~~~~~~

Provides a two github actions workflows.

**To Enable:**

Add ``lyft/github_workflows`` to your ``boilerplate/update.cfg`` file.

Create 3 secrets in github -> repo settings:
	- ``flytegithub_repo`` is the repo name that will be used to push images to dockerhub as well as to github docker repo.
	- ``flytegithub_dockerhub_username`` with a user in dockerhub that has permissions to push to the repo.
	- ``flytegithub_dockerhub`` with the password for the above user.

The actions will push to 4 repos:

	1. ``docker.io/lyft/<repo>``
	2. ``docker.io/lyft/<repo>-stages`` : this repo is used to cache build stages to speed up iterative builds after.
	3. ``docker.pkg.github.com/lyft/<repo>/operator``
	4. ``docker.pkg.github.com/lyft/<repo>/operator-stages`` : this repo is used to cache build stages to speed up iterative builds after.
