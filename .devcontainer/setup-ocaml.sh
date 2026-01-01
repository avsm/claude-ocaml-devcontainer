#!/bin/bash
set -e

echo "Installing OCaml dependencies..."
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    curl \
    git \
    unzip \
    bubblewrap \
    m4 \
    opam \
    ripgrep \
    vim \
    pkg-config \
    libgmp-dev

echo "Initializing opam..."
opam init --disable-sandboxing -y
eval $(opam env)

echo "Installing OCaml LSP server and common tools..."
opam install -y \
    ocaml-lsp-server \
    dune \
    merlin \
    ocamlformat \
    odoc \
    utop \
    cohttp-eio \
    tls-eio \
    progress \
    decompress \
    eio_main \
    ezjsonm \
    decompress \
    zarith \
    re \
    ca-certs \
    syndic \
    alcotest \
    ctypes \
    ctypes-foreign \
    lambdasoup \
    cmarkit \
    yaml \
    jekyll-format \
    jsont \
    bytesrw 

echo "Initialising OxCaml..."

opam switch create 5.2.0+ox --repos ox=git+https://github.com/oxcaml/opam-repository.git,default
eval $(opam env --switch 5.2.0+ox)
opam install -y \
  async ocamlformat merlin ocaml-lsp-server utop core parallel

opam switch default
eval $(opam env)

echo "Setting up shell environment..."
echo 'eval $(opam env)' >> ~/.bashrc

echo "OCaml setup complete!"
opam --version
ocaml --version
which ocamllsp
