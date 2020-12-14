class DashPage
    include Capybara::DSL

    def on_dash?
        page.has_css?(".dashboard")
    end

    def goto_equipo_form
        click_button "Criar anúncio"
    end

    def equipo_list
        find("ul.equipo-list")
    end

   def has_no_equipo?(name)
    return page.has_no_css?(".equipo-list li", text: name)
    end

    def request_remove(name)
        equipo = find(".equipo-list li", text: name)
        equipo.find(".delete-icon").click
    end

    def confirm_remove
        click_on "Sim"
    end

    def cancel_remove
        click_on "Não"
    end

    def pedido
        find('.notifications p')
    end

    def pedido_actions(acao) 
        page.has_css?(".notifications button", text: acao)
    end
end