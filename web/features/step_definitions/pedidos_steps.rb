Dado('que meu perfil de anunciante é {string} e {string}') do |email, senha|
    @email_anunciante = email
    @senha_anunciante = senha
end
  
Dado('que eu tenho o seguinte equipamento cadastrado:') do |table|
    user_id = SessionService.new.get_user_id(@email_anunciante, @senha_anunciante)
    
    thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

    @equipo = {
        thumbnail: thumbnail,
        name: table.rows_hash[:nome],
        category: table.rows_hash[:categoria],
        price: table.rows_hash[:preco],
    }

    MongoDB.new.remove_equipo(@equipo[:name], @email_anunciante)

    result = EquiposService.new.create(@equipo, user_id)
    @equipo_id = result.parsed_response["_id"]
end
  
Dado('acesso o meu dashboard') do
    @login_page.abrir
    @login_page.logar(@email_anunciante, @senha_anunciante)

    # Checkpoint
    expect(@dash_page.on_dash?).to be true
end
  
Quando('{string} e {string} solicita a locação desse equipo') do |email, senha|
    locatario_id = SessionService.new.get_user_id(email, senha)

    EquiposService.new.booking(@equipo_id, locatario_id)
end
  
Então('devo ver a seguinte mensagem:') do |doc_string|
    msg_esperada = doc_string.gsub("DATA_ATUAL", Time.now.strftime("%d/%m/%Y"))

    expect(@dash_page.pedido).to have_text msg_esperada
end
  
Então('devo ver os links: {string} e {string} no pedido') do |btn_aceitar, btn_rejeitar|
    # expect(page).to have_selector ".notifications button", text: btn_aceitar
    # expect(page).to have_selector ".notifications button", text: btn_rejeitar

    expect(@dash_page.pedido_actions(btn_aceitar)).to be true
    expect(@dash_page.pedido_actions(btn_rejeitar)).to be true
end