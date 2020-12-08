#language: pt

Funcionalidade: login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "silva@gmail.com" e "teste652"
        Então sou redirecionado para o Dashboard

    @tenta_logar
    Esquema do Cenário: Tentar logar

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<msg_ontput>"

        Exemplos:
            | email_input           | senha_input | msg_ontput                       |
            | sf.rafael20@gmail.com | teste652    | Usuário e/ou senha inválidos.    |
            | sf.rafael11@gmail.com | teste652    | Usuário e/ou senha inválidos.    |
            | sf.rafael20$gmail.com | teste652    | Oops. Informe um email válido!   |
            | sf.rafael20*gmail.com | teste652    | Oops. Informe um email válido!   |
            |                       | teste652    | Oops. Informe um email válido!   |
            | sf.rafael20@gmail.com |             | Oops. Informe sua senha secreta! |