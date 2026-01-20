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
    libgmp-dev \
    afl++

echo "Initializing opam..."
opam init -c 5.4.0 --disable-sandboxing -y
eval $(opam env)

echo "Installing OCaml LSP server and common tools..."
opam install -y \
    ocaml-lsp-server \
    dune \
    merlin \
    ocamlformat \
    odoc \
    utop \
    decompress \
    zarith \
    re \
    cmdliner \
    fmt \
    alcotest \
    crowbar \
    ctypes \
    ctypes-foreign \
    jsont \
    bytesrw 

opam clean -a
echo "Initialising OxCaml..."

opam switch create 5.2.0+ox --repos ox=git+https://github.com/oxcaml/opam-repository.git,default
eval $(opam env --switch 5.2.0+ox)
opam install -y \
  async ocamlformat merlin ocaml-lsp-server utop core parallel

opam clean -a
opam switch default
eval $(opam env)

echo "Setting up shell environment..."
echo 'eval $(opam env)' >> ~/.bashrc

echo "OCaml setup complete!"
opam --version
ocaml --version
which ocamllsp
