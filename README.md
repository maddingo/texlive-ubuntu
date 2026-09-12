# texlive-ubuntu

Docker image for building the [mtn-master-thesis](https://github.com/maddingo/mtn-master-thesis)
LaTeX document in CI: full TeX Live (XeLaTeX, biber, latexmk) plus `pandoc`
and `make`, so `make`, `make refs-overview`, `make docx` and `make md` can
all run in the same container instead of splitting the build between
`xu-cheng/latex-action`'s Docker step and the plain GitHub runner.

Also bakes in the Lato font fix (removes the broken Type1 build from TeX
Live, uses Ubuntu's `fonts-lato` instead) at build time, instead of running
it as a `pre_compile` step on every CI run.

## Publishing

Pushing a change to `Dockerfile` on `main` builds and pushes:

- `ghcr.io/maddingo/texlive-ubuntu:latest`
- `ghcr.io/maddingo/texlive-ubuntu:<sha>`

After the first successful run, check the package's visibility under
**GitHub → your profile → Packages → texlive-ubuntu → Package settings** and
make sure it's set to **Public** (needed so the private `mtn-master-thesis`
workflow can pull it without an extra access token).

## Using it from mtn-master-thesis

Replace the `xu-cheng/latex-action` step with a container-scoped job, e.g.:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/maddingo/texlive-ubuntu:latest
    steps:
      - uses: actions/checkout@v7
      - run: make
      - run: make refs-overview
      - run: make docx
      - run: make md
```
