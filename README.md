# desafioKabum

Projeto do desafio da Kabum.

<!-- Este projeto usa XcodeGen para evitar conflitos e deixar o projeto mais limpo e leve no git.
Para rodar o projeto é necessario:  -->
Requisitos para rodar:
- Instalar Cocoapods 
- Executar `Pod Install` para que os pod usados sejam instalados
<!-- - ter instalado o Xcodegen (https://github.com/yonaskolb/XcodeGen)
- Executar o comando `xcodegen generate` na pasta que contem o arquivo project.yml -->

Este projeto apresenta uma Galeria de produtos "infinita" fazendo paginação conforme é feito o scroll na tela, até que chega-se a chamada sem retorno, onde as chamadas são paradas para evitar gasto desnecessario de banda do usuario.
Em caso de erro na chamada uma mensagem vermelha surgirá no topo da tela apresentando a mensagem de erro vinda da chamada.
As células apresentam a imagem do produto, nome, preço e avaliação. Caso tenha disconto tambem é apresentado o valor antigo eme cinza e a porcentagem de desconto. Por ter muitos dados, as células foram feitas coma arquitetura MVVM. O que permite um baixo acoplamento entre a view e a Chamada da API.
No Footer da CollectionView coloquei uma `UIActivityIndicatorView` que só aparece e anima enquanto estiver sendo feita uma chamada.
Os testes unitarios fetos geram uma cobertura de mais de 80%
