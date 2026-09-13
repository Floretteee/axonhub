# Downstream fork overlay

This directory is the single source of truth for this fork's customizations.
The upstream sync workflow resets the checkout to `upstream/unstable`, restores
this directory, and runs `apply.sh` to re-apply the overlay.

Keep fork-specific workflow and Compose changes here. Do not permanently edit
upstream-owned files by hand, and do not maintain a fork version by changing
`internal/build/VERSION`; the publish workflow writes the traceable unstable
build version while it builds an image.

## Docker Compose

Run the upstream Compose configuration with this fork's image override:

```sh
docker compose -f docker-compose.yml -f docker-compose.fork.yml up -d
```

The override uses `ghcr.io/floretteee/axonhub:unstable` by default. Set
`COMPOSE_IMAGE_OWNER` to select another GHCR owner and `COMPOSE_IMAGE_TAG` to
select another image tag, for example:

```sh
COMPOSE_IMAGE_OWNER=example COMPOSE_IMAGE_TAG=unstable-abc123def456 \
  docker compose -f docker-compose.yml -f docker-compose.fork.yml up -d
```
