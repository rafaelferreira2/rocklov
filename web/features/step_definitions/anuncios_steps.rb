Dado('Login com {string} e {string}') do |email, senha|
    @email = email
    
    @login_page.abrir
    @login_page.logar(email, senha)

    # Checkpoint
    expect(@dash_page.on_dash?).to be true
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

# Remover anúncios

Dado('que eu tenho um anúncio indesejado:') do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")
    # log user_id

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
      thumbnail: thumbnail,
      name: table.rows_hash[:nome],
      category: table.rows_hash[:categoria],
      price: table.rows_hash[:preco],
  }

  EquiposService.new.create(@equipo, user_id)

  visit current_path
end
  
Quando('eu solicito a exclusão desse item') do
  @dash_page.request_remove(@equipo[:name])
  sleep 1
end
  
Quando('confirmo a exclusão') do
  @dash_page.confirm_remove
end

Quando('não confirmo a exclusão') do
  @dash_page.cancel_remove
end
  
Então('não devo ver esse item no meu Dashboard') do
  expect(
    @dash_page.has_no_equipo?(@equipo[:name])
  ).to be true
end

Então('esse item deve permanecer no meu Dashboard') do
  expect(@dash_page.equipo_list).to have_content @equipo[:name]
  expect(@dash_page.equipo_list).to have_content "R$#{@equipo[:price]}/dia"
end