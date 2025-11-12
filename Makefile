# Nome do executável
EXEC = passeio_cavalo

# Arquivo principal
MAIN = Main.hs

# Flags do compilador
GHCFLAGS = --make -O2

# Arquivos fonte (ajuste conforme seus arquivos .hs)
SRC = Main.hs \
      InputParser.hs \
      KnightLogic.hs \
      KnightSolver.hs

# Regra padrão (gera o executável)
all: $(EXEC)

$(EXEC): $(SRC)
	ghc $(GHCFLAGS) $(MAIN) -o $(EXEC)

# Executa o programa com o arquivo de entrada
run: $(EXEC)
	./$(EXEC) input.txt

# Remove arquivos compilados
clean:
	rm -f $(EXEC) *.hi *.o

# Força recompilação completa
rebuild: clean all
