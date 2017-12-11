# Rsync SSH Docker

Docker image to allow SSH and rsync access to volumes.
Authentication is configured using github public keys- the container creates users and downloads their github keys at runtime.

## Environment variables

- `GROUPID`: The numeric ID of the group all users will be added to, default `1000`
- `GITHUB_USERS`: List of GitHub users to be created using the public GitHub keys

## Example

    docker run -d --name rsync-ssh-access -v shared-volume:/volume \
        -e GITHUB_USERS="microscopepony snoopycrimecop" -p 10022:22 rsync-ssh

    rsync -v -e 'ssh -p 10022' microscopepony@localhost:/volume
    ssh -p 10022 microscopepony@localhost
