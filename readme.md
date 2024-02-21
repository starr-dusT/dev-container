# Dev Container
> You don't use NixOS for dev? Big L.

I'm not smart enough to make some python stuff work in NixOS so I develop in a
container most of the time. In addition, this has the nice benefit of being
useful for development on locked down work machines.

## Usage

Pull the container and run it.

```bash
docker pull ghcr.io/starr-dust/dev-container:master
docker run --rm --name "$(date +%Y%m%d%k%M%S)" -p 8080:8080 -v $(pwd):/root/src -it ghcr.io/starr-dust/dev-container:master
```
