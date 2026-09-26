# texlive-ubuntu

Docker image for building latex projects with latexmk. 

LaTeX document in CI: full TeX Live (XeLaTeX, biber, latexmk) plus `pandoc`
and `make`.

Also bakes in the Lato font fix (removes the broken Type1 build from TeX
Live, uses Ubuntu's `fonts-lato` instead) at build time.

## Publishing

Pushing a change to `Dockerfile` on `main` builds and pushes:

- `ghcr.io/maddingo/texlive-ubuntu:latest`
- `ghcr.io/maddingo/texlive-ubuntu:<sha>`

## Using it for a TeXLive project


```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/maddingo/texlive-ubuntu:latest
    steps:
      - uses: actions/checkout@v7
      - run: latexmk main.tex
```
