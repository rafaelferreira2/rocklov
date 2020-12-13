

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
end