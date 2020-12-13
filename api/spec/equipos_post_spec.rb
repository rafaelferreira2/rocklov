
describe "POST /equipos" do

    before(:all) do
        payload = { email: "teste@mail.com", password: "teste652"}
        resultado = Sessions.new.login(payload)
        @user_id = resultado.parsed_response["_id"]
    end

    context "Novo equipo" do

        before(:all) do
            payload = {
                thumbnail: Helpers::get_thumb("kramer.jpg"),
                name: "Kramer Eddie Van Halen",
                category: "Cordas",
                price: 299
            }

            MongoDB.new.remove_equipo(payload[:name], @user_id)
            
            @resultado = Equipos.new.create(payload, @user_id)
        end

        it "Deve retornar 200" do
            expect(@resultado.code).to eql 200
        end
    end

    context "Não autorizado" do


        before(:all) do
            payload = {
                thumbnail: Helpers::get_thumb("baixo.jpg"),
                name: "Contra Baixo",
                category: "Cordas",
                price: 60
            }
            
            @resultado = Equipos.new.create(payload, nil)
        end

        it "Deve retornar 401" do
            expect(@resultado.code).to eql 401
        end
    end


end