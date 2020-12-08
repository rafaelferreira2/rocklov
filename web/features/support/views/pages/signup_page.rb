
class SignupPage
    include Capybara::DSL


    def abrir
        visit "/signup"
    end

    def cadastra_usuario(user)
        find("#fullName").set user[:nome]
        find("#email").set user[:email]
        find("#password").set user[:senha]

        click_button "Cadastrar"
    end

end