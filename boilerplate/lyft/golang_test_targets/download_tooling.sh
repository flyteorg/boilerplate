#!/bin/bash

# Everything in this file needs to be installed outside of current module
# The reason we cannot turn off module entirely and install is that we need the replace statement in go.mod
# because we are installing a mockery fork. Turning it off would result installing the original not the fork.
# However, because the installation of these tools themselves sometimes modifies the go.mod/go.sum files. We don't
# want this either. So instead, we're going to copy those files into a temporary directory, do the installation, and=
# ignore any changes made to the go mod files.
# (See https://github.com/golang/go/issues/30515 for some background context)

go_get_mockery () {
  tmp_dir=$(mktemp -d -t gotooling-XXXXXXXXXX)
  echo tmp_dir
  cp go.mod go.sum "$tmp_dir"
  pushd "$tmp_dir"
  go get github.com/vektra/mockery/cmd/mockery
  popd
}

go_get_pflags () {
  tmp_dir=$(mktemp -d -t gotooling-XXXXXXXXXX)
  cp go.mod go.sum "$tmp_dir"
  pushd "$tmp_dir"
  go get github.com/lyft/flytestdlib/cli/pflags
  popd
}

go_get_lint () {
  tmp_dir=$(mktemp -d -t gotooling-XXXXXXXXXX)
  cp go.mod go.sum "$tmp_dir"
  pushd "$tmp_dir"
  go get github.com/golangci/golangci-lint/cmd/golangci-lint
  popd
}

go_get_enumer () {
  tmp_dir=$(mktemp -d -t gotooling-XXXXXXXXXX)
  cp go.mod go.sum "$tmp_dir"
  pushd "$tmp_dir"
  go get github.com/alvaroloes/enumer
  popd
}

go_get_mockery
go_get_pflags
go_get_lint
go_get_enumer
