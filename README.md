# Storm with daily `apt-get update & upgrade`

This is a clone of Dockerfile for [Storm 1.1, 1.2, 2.1 & 2.2](https://storm.apache.org/) with `apt-get update & upgrade` applied.

## Tags

- latest-apt
- 1.1-apt
- 1.2-apt
- 2.1-apt
- 2.2-apt

## Testing

Tests are defined in `test-image.yaml` using [GoogleContainerTools/container-structure-test](
https://github.com/GoogleContainerTools/container-structure-test). To run tests, execute `./test-image.sh`. 

## Usage

Please refer to [storm](https://hub.docker.com/_/storm/).
