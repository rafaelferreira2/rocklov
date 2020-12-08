
Dado('que acesso a página de cadastro') do
    @signup_page.abrir
end

Quando('submeto o seguinte formulário de cadastro:') do |table|

    user = table.hashes.first
    MongoDB.new.remove_user(user[:email])
    
    @signup_page.cadastra_usuario(user)
end

