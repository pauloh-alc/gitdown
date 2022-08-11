# gitdown
gitdown é capaz de realizar o download de um diretório ou arquivo específico dado a URL de algum repositório do github.

- gitdown é compatível com distribuições Linux.

## Tecnologia

- Shell Script

## Sinopse
```sh
user@localhost:~$ ./gitdown.sh [repository URL] [file or directory]
```
## Exemplos
- Modo de uso
```sh
git clone https://github.com/pauloh-alc/gitdown
cd gitdown
```
- Verifique se o arquivo gitdown.sh possui permissão de execução
```sh
ls -l gitdown.sh
```
- Caso o script gitdown.sh não possua permissão de execução. Dê permissão
```sh
chmod +x gitdown.sh
```
-  para download de um diretório
```sh
./gitdown.sh https://github.com/pauloh-alc/AVL-tree.git list-of-questions
```
- para download de um arquivo (necessário informar sua extensão)
```sh
./gitdown.sh https://github.com/pauloh-alc/AVL-tree.git avl.pdf
```

## Testado
- bash 5.1.16

## Licença

GLPv3

**Free Software**
