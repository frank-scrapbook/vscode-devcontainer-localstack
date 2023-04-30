# localstack devcontainer feature notes

Latest build for localstack failed: https://github.com/devcontainers-contrib/features/actions/runs/4821656678/jobs/8587876823
- [nanolayer updated from v0.4.27 to v0.4.29](https://github.com/devcontainers-contrib/features/pull/392/files#diff-802e32de235d2943eeed18cdead14560747d0953106071138f1b00520f4d3393)

Resolved by Daniel Braun: https://github.com/devcontainers-contrib/features/issues/398#issuecomment-1529001418
- pipx `install-deps`
- `/var/lib/localstack` may not be created due to non-root

Ref:
- https://docs.localstack.cloud/references/filesystem/
