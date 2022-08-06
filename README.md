# gitdown
gitdown é capaz de realizar o download de um diretório ou arquivo específico dado a URL de algum repositório do github.

- gitdown é compatível com distribuições Linux.

## Tecnologia

gitdown utiliza --shell-scrit-- como base.

## Sinopse
```sh
user@localhost:~$ ./gitdown.sh [repository URL] [file or directory]
```
## Exemplos
-  download de um diretório
```sh
user@localhost:~$ ./gitdown.sh https://github.com/pauloh-alc/AVL-tree.git list-of-questions
```

- download de um arquivo (necessário informar sua extensão)
```sh
user@localhost:~$ ./gitdown.sh https://github.com/pauloh-alc/AVL-tree.git avl.pdf
```

## Testado
- bash 5.1.16

## Licença

MIT

**Free Software**
