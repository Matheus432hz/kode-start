# Desafio Técnico – Kode Start 2025 

Esta é a minha solução para o desafio técnico do programa Kode Start 2025 da Kobe Apps.

O aplicativo foi desenvolvido em Flutter e consome a API REST pública de Rick and Morty para exibir uma lista de personagens e seus detalhes, seguindo o design proposto no Figma.

## Funcionalidades Implementadas

* Listagem de personagens com scroll.
* Exibição de nome e imagem do personagem em cards customizados.
* Navegação para uma tela de detalhes ao clicar em um personagem.
* Tela de detalhes com todas as informações obrigatórias (nome, imagem, status, espécie, etc.).
* Tema dinâmico (Light/Dark Mode) com um botão de troca na AppBar.

## Arquitetura e Padrões

O projeto foi estruturado de forma organizada para separar as responsabilidades:

* **`main.dart`**: Ponto de entrada do aplicativo, onde o tema e a navegação inicial são configurados.
* **`models/`**: Contém a classe `Character` (`character_model.dart`), que modela os dados recebidos da API.
* **`services/`**: A classe `ApiService` (`api_service.dart`) é responsável por toda a comunicação com a API REST (fazer as requisições HTTP).
* **`components/`**: Widgets reutilizáveis, como a `AppBarComponent` e o `CardCharacterComponent`, para manter o código da UI limpo e modular.
* **`controllers/`**: O `ThemeController` gerencia o estado do tema (claro/escuro) utilizando o pacote `provider`.
* **`theme/`**: Arquivos de configuração de estilo, como `app_colors.dart` e `app_images.dart`, para centralizar o design do app.
* **State Management**: Foi utilizado o pacote `provider` para o gerenciamento de estado do tema, e o widget `FutureBuilder` para gerenciar o estado assíncrono das chamadas à API.