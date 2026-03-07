build:
    rm -rf public
    ~/.cargo/bin/zola build
    ~/.cargo/bin/precompress public --extensions html,js,css,xml,txt

install-deps:
    cargo install --locked --git https://github.com/getzola/zola
    cargo install precompress

wait-ssh-ready host:
    until ssh {{host}} true >/dev/null 2>&1; do sleep 1; done

deploy-victorsavu: build (wait-ssh-ready "victorsavu@victorsavu.eu")
    rsync -rzP --delete public/ victorsavu@victorsavu.eu:victorsavu/