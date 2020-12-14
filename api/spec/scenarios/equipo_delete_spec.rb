#encoding: utf-8

describe "DELETE /equipos/{equipo_id}" do

    before(:all) do
        payload = { email: "teste@mail.com", password: "teste652"}
        resultado = Sessions.new.login(payload)
        @user_id = resultado.parsed_response["_id"]
    end

    context "Remove equipo" do

        before(:all) do
            @payload = {
                thumbnail: Helpers::get_thumb("pedais.jpg"),
                name: "Pedais de um cara",
                category: "Áudio e Tecnologia".force_encoding("ASCII-8BIT"),
                price: 185
            }

            MongoDB.new.remove_equipo(@payload[:name], @user_id)
            
            equipo = Equipos.new.create(@payload, @user_id)
            @equipo_id = equipo.parsed_response["_id"]

            @resultado = Equipos.new.remove_by_id(@equipo_id, @user_id)
        end

        it "Deve retornar 204" do
            expect(@resultado.code).to eql 204
        end

    end

    context "Equipo não existe" do

        before(:all) do
            @resultado = Equipos.new.remove_by_id(MongoDB.new.get_mongo_id, @user_id)
        end

        it "deve retornar 204" do
            expect(@resultado.code).to eql 204
        end

    end
end