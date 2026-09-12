FROM texlive/texlive:latest

# Overleaf/TeX Live's bundled Type1 "Lato" font (typoland/lato) has a broken
# accented glyph that crashes xdvipdfmx. Use Ubuntu's fonts-lato (TrueType)
# instead, so fontspec falls back to a working build. pandoc and make are
# not part of the TeX Live image and are needed for `make docx`/`make md`.
RUN apt-get update && apt-get install -y --no-install-recommends \
        fonts-lato \
        pandoc \
        make \
    && find / -ipath '*type1*typoland/lato*.pfb' -delete \
    && fc-cache -f \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
