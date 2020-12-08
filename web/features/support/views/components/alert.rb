
class Alert
    include Capybara::DSL
    
    def alert_dark
        find(".alert-dark").text
    end
end