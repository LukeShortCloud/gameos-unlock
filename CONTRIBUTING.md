# Contributing

Table of Contents:
- [bootc Builds](#bootc-builds)

## bootc Builds

After a tagged release, build and upload the latest bootc container.

```
$ podman build bootc/ --tag quay.io/lukeshortcloud/gameos-unlock:${VERSION}
$ podman push quay.io/lukeshortcloud/gameos-unlock:${VERSION}
$ podman tag quay.io/lukeshortcloud/gameos-unlock:${VERSION} quay.io/lukeshortcloud/gameos-unlock:latest
$ podman push quay.io/lukeshortcloud/gameos-unlock:latest
```
