

describe "GET /equipos/{equipo_id}" do

    before(:all) do
        payload = { email: "teste@mail.com", password: "teste652"}
        resultado = Sessions.new.login(payload)
        @user_id = resultado.parsed_response["_id"]
    end

    context "Obter unico equipo" do

        before(:all) do
            @payload = {
                thumbnail: Helpers::get_thumb("sanfona.jpg"),
                name: "Sanfona",
                category: "Outros",
                price: 499
            }

            MongoDB.new.remove_equipo(@payload[:name], @user_id)
            
            equipo = Equipos.new.create(@payload, @user_id)
            @equipo_id = equipo.parsed_response["_id"]

            @resultado = Equipos.new.find_by_id(@equipo_id, @user_id)
        end

        it "Deve retornar 200" do
            expect(@resultado.code).to eql 200
        end

        it "Deve retornar o nome" do
            expect(@resultado.parsed_response).to include("name" => @payload[:name])
        end

    end

    context "Equipo não existe" do

        before(:all) do
            @resultado = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
        end

        it "deve retornar 404" do
            expect(@resultado.code).to eql 404
        end

    end
end

describe "GET /equipos" do
    before(:all) do
        payload = { email: "penelope@mail.com", password: "teste652"}
        resultado = Sessions.new.login(payload)
        @user_id = resultado.parsed_response["_id"]
    end

    context "Obter uma lista" do
        before(:all) do
            payloads = [
                {
                    thumbnail: Helpers::get_thumb("sanfona.jpg"),
                    name: "Sanfona",
                    category: "Outros",
                    price: 499
                }, 
                {
                    thumbnail: Helpers::get_thumb("trompete.jpg"),
                    name: "Trompete",
                    category: "Outros",
                    price: 577
                },
                {
                    thumbnail: Helpers::get_thumb("slash.jpg"),
                    name: "Les Paul",
                    category: "Outros",
                    price: 650
                }
            ]

            payloads.each do |payload|
                MongoDB.new.remove_equipo(payload[:name], @user_id)
                Equipos.new.create(payload, @user_id)
            end

            @resultado = Equipos.new.list(@user_id)
        end

        it  "deve retornar 200" do
            expect(@resultado.code).to eql 200
        end

        it "deve retornar uma lista de equipos" do
            expect(@resultado.parsed_response).not_to be_empty
        end
    end

end