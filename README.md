# craved-docker
Crave (CRAVE) Daemon / Wallet Blockchain in Docker

This container uses the cryptocoin-base container (https://quay.io/repository/kwiksand/cryptocoin-base) which installs ubuntu and all the bitcoin build dependencies (miniupnp, berkelyDB 4.8, system build tools, etc)

Note:
- Use port 30104! Craved won't connect correctly to the network with a different port
- See Crave Masternode guide at: https://bitcointalk.org/index.php?topic=1964765.msg19605633#msg19605633
- Also see my other guide/wiki for Arcticcoin (ARC), for almost the same process: https://github.com/kwiksand/arcticoind-docker/wiki
