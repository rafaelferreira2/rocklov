Dado('Login com {string} e {string}') do |email, senha|
    @email = email
    
    @login_page.abrir
    @login_page.logar(email, senha)
end
  
Dado('que acesso o formulário de cadastro de anúncios') do
    @dash_page.goto_equipo_form
end

Dado('que eu tenho o seguinte equipamento:') do |table|
    @anuncio = table.rows_hash

    MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end
  
Quando('submeto o cadastro desse item') do
    @equipos_page.cria_equipo(@anuncio)
end
  
Então('devo ver esse item no meu Dashboard') do
    expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
    expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end