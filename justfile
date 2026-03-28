set dotenv-load := true

build:
    rm -rf public
    ~/.cargo/bin/zola build
    ~/.cargo/bin/precompress public

install-deps:
    cargo install --locked --git https://github.com/getzola/zola
    cargo install precompress
    pip3 install jingtrang

wait-ssh-ready host:
    until ssh {{host}} true >/dev/null 2>&1; do sleep 1; done

deploy: build (wait-ssh-ready "victorsavu@victorsavu.eu")
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

validate-bimi:
    curl https://bimigroup.org/resources/SVG_PS-latest.rnc.txt -o SVG_PS-latest.rnc.txt
    pyjing -c SVG_PS-latest.rnc.txt static/bimi-logo.svg

favicon-ico:
    magick static/favicon-background.svg -bordercolor white -border 0 \
          \( -clone 0 -resize 16x16 \) \
          \( -clone 0 -resize 32x32 \) \
          \( -clone 0 -resize 48x48 \) \
          \( -clone 0 -resize 64x64 \) \
          \( -clone 0 -resize 128x218 \) \
          \( -clone 0 -resize 256x256 \) \
          -delete 0 -alpha off -colors 256 static/favicon.ico
