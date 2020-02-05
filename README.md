# Docker Image for VMWare PowerCLI + OVFTool

## Building Docker Image

*Requires manually downloading the ovftool to `src/`*.

```
$ cp -a path/to/VMWare-ovftool-*.bundle src/

$ docker build trueability/powercli-ovftool:latest .
```
