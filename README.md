# MkDocs Container

## Overview
This container contains:
- [MkDocs](https://www.mkdocs.org)
- [Material for MkDocs](https://github.com/squidfunk/mkdocs-material)
- [PlantUML](http://plantuml.com/en/index)

## Getting Started
1. Make your initial project like below
```
project
├─ docs
│   └─ index.md
└─ mkdocs.yaml
```
2. Run docker container
```
docker run -v ${PWD}:/docs iyuichi/mkdocs-material-plantuml
```
3. Open mkdocs page in your browser  
[http://127.0.0.1:8000/](http://127.0.0.1:8000/)