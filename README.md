# Passeio do Cavalo

Implementação do **Problema do Passeio do Cavalo** (_Knight’s Tour_) em **Haskell**, utilizando a **heurística de Warnsdorff**.

---

## Instalação do ambiente Haskell

Para compilar e executar o projeto, é necessário ter o **Haskell** e o **GHC** instalados.  
A forma mais simples é utilizando o **GHCup**.

🔗 [Guia oficial de instalação do GHCup](https://www.haskell.org/ghcup/install/)

---

## Compilação e execução

### Usando GHCup diretamente
```bash
ghc --make Main.hs -O2 -o passeio_cavalo && ./passeio_cavalo input.txt
```

### Usando Makefile
```bash
make && make run
```

### Referências

[Problema do passeio do cavalo](https://en.wikipedia.org/wiki/Knight%27s_tour)

[heurística de warnsdorff](https://en.wikipedia.org/wiki/Knight%27s_tour)