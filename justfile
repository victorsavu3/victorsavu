set dotenv-load := true

build:
    rm -rf public
    ~/.cargo/bin/zola build
    ~/.cargo/bin/precompress public

install-deps:
    cargo install --locked --git https://github.com/getzola/zola
    cargo install precompress

wait-ssh-ready host:
    until ssh {{host}} true >/dev/null 2>&1; do sleep 1; done

deploy-victorsavu: build (wait-ssh-ready "victorsavu@victorsavu.eu")
    rsync -rzP --delete public/ victorsavu@victorsavu.eu:victorsavu/

serve:
    firefox http://127.0.0.1:1111
    ~/.cargo/bin/zola serve

create-release: build
    tar -cvf public.tar.xz public/
    curl -v --user victor:${FORGEJO_TOKEN} \
        --upload-file public.tar.xz \
        https://forgejo.victorsavu.eu/api/packages/victor/generic/victorsavu/{{ datetime("%Y-%m-%d_%H-%M") }}/www.tar.xz
    rm public.tar.xz

import-cv:
    ps2pdf ../cv/document.pdf static/cv.pdf
