Dado('que acesso a página principal') do
    @login_page.abrir
end
  
Quando('submeto minhas credenciais com {string} e {string}') do |email, senha|
    
    @login_page.abrir
    @login_page.logar(email, senha)
end