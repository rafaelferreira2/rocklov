#language: pt

Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome            | email                 | senha    |
            | Rafael Ferreira | sf.rafael20@gmail.com | teste652 |
        Então sou redirecionado para o Dashboard

    @tentativa_cadastro
    Esquema do Cenario: Tentativa de cadastro
        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |

        Então vejo a mensagem de alerta: "<msg_ontput>"

        Exemplos:
            | nome_input      | email_input           | senha_input | msg_ontput                       |
            |                 | sf.rafael20@gmail.com | teste652    | Oops. Informe seu nome completo! |
            | Rafael Ferreira |                       | teste652    | Oops. Informe um email válido!   |
            | Rafael Ferreira | sf.rafael20$gmail.com | teste652    | Oops. Informe um email válido!   |
            | Rafael Ferreira | sf.rafael20*gmail.com | teste652    | Oops. Informe um email válido!   |
            | Rafael Ferreira | sf.rafael20@gmail.com |             | Oops. Informe sua senha secreta! |