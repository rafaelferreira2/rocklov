#language: pt

Funcionalidade: Cadastro de anúncios
    Sendo usuário cadastrado no Rocklov que possui equipamentos musicais
    Quero cadastrar meus equipamentos
    Para que eu póssa disponibilizados para locação

    Contexto: Login
        * Login com "teste@mail.com" e "teste652"

    @novo_equipo
    Cenario: Novo equipamento

        Dado que acesso o formulário de cadastro de anúncios
            E que eu tenho o seguinte equipamento:
            | thumb     | fender-sb.jpg |
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro desse item
        Então devo ver esse item no meu Dashboard

    Esquema do Cenario: Tentativa de cadastro de anúncios

        Dado que acesso o formulário de cadastro de anúncios
            E que eu tenho o seguinte equipamento:
            | thumb     | <foto>      |
            | nome      | <nome>      |
            | categoria | <categoria> |
            | preco     | <preco>     |
        Quando submeto o cadastro desse item
        Então deve conter a mensagem de alerta: "<msg_esperada>"

        Exemplos:
            | foto          | nome              | categoria | preco | msg_esperada                        |
            |               | Violão de nylon   | Cordas    | 150   | Adicione uma foto no seu anúncio!   |
            | clarinete.jpg |                   | Outros    | 250   | Informe a descrição do anúncio!     |
            | mic.jpg       | Microfone Shure   |           | 100   | Informe a categoria                 |
            | trompete.jpg  | Trompete clássico | Outros    |       | Informe o valor da diária           |
            | conga.jpg     | Conga             | Baterias  | abc   | O valor da diária deve ser numérico |
            | conga.jpg     | Conga             | Baterias  | 100a  | O valor da diária deve ser numérico |