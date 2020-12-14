#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anúnciante que possui um equipamento indesejado
    Quero poder remover esse anúncio
    Para que eu possa manter meu dashboard atualizado

    Contexto: Login
        * Login com "spider@mail.com" e "teste652"

    Cenario: Remover um anúncio

        Dado que eu tenho um anúncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Fender Strato  |
            | categoria | Cordas         |
            | preco     | 75             |
        Quando eu solicito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu Dashboard

    Cenario: Desistir da exclusão

        Dado que eu tenho um anúncio indesejado:
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 89        |
        Quando eu solicito a exclusão desse item
            Mas não confirmo a exclusão
        Então esse item deve permanecer no meu Dashboard