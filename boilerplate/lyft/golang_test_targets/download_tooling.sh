#!/bin/bash

# Everything in this file needs to be installed outside of current module
# The reason we cannot turn off module entirely and install is that we need the replace statement in go.mod
# because we are installing a mockery fork. Turning it off would result installing the original not the fork.
# However, because the installation of these tools themselves sometimes modifies the go.mod/go.sum files. We don't
# want this either. So instead, we're going to copy those files into a temporary directory, do the installation, and
# ignore any changes made to the go mod files.
# (See https://github.com/golang/go/issues/30515 for some background context)

set -e

# List of tools to go get
# In the format of "<cli>:<package>" or ":<package>" if no cli
tools=(
  "mockery:github.com/vektra/mockery/cmd/mockery"
  "pflags:github.com/lyft/flytestdlib/cli/pflags"
  "golangci-lint:github.com/golangci/golangci-lint/cmd/golangci-lint"
  "enumer:github.com/alvaroloes/enumer"
)

tmp_dir=$(mktemp -d -t gotooling-XXX)
echo "Using temp directory ${tmp_dir}"
cp -R boilerplate/lyft/golang_support_tools/* $tmp_dir
pushd "$tmp_dir"

for tool in "${tools[@]}"
do
    cli=$(echo "$tool" | cut -d':' -f1)
    package=$(echo "$tool" | cut -d':' -f2)
    echo "Installing ${package}"
    GO111MODULE=on go install "$package"
done

popd
