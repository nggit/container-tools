# container-tools
A collection of scripts around containers and networking. Written in POSIX (sh) and expected to run on busybox (Alpine Linux) and GNU without dependency issues.

| Name                                   | Example                            | Summary                               |
|----------------------------------------|----------------------------------- |---------------------------------------|
| [getcontainer.sh](src/getcontainer.sh) | `pid=123; ./getcontainer.sh $pid`  | When doing `top` on the Docker host and wondering which container is to blame for running a particular process. |
| [getveth.sh](src/getveth.sh)           | `sh src/getveth.sh container_name` | When doing `if link` on the Docker host, we see some `veth*` interfaces and are curious to find out which container it belongs to. |

## Lincense
MIT License
