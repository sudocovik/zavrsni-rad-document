FROM ubuntu:latest AS base

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
        biber \
        latexmk \
        texlive-bibtex-extra \
        texlive-lang-european \
        texlive-latex-base \
        texlive-latex-extra \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /build && \
    mkdir /build/out && \
    mkdir /build/src

WORKDIR /build/src


FROM base AS development-environment

ARG uid=1000

RUN useradd --no-create-home \
            --uid=${uid} \
            runner

RUN chown runner /build/out && \
    chown runner /build/src && \
    chmod 700 /build/out && \
    chmod 500 /build/src

USER runner

SHELL ["/bin/bash", "-c"]

CMD ["latexmk", "-pdf", "-pvc", "-output-directory=../out", "-Werror"]
