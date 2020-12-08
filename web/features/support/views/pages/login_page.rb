class LoginPage
    include Capybara::DSL

    def abrir
        visit "/"
    end

    def logar(email, senha)
        find("input[placeholder='Seu email']").set email
        find("input[type=password]").set senha
        click_button "Entrar"
    end

end

