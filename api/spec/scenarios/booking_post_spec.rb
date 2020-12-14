

describe "POST /equipos/{equipo_id}/bookings}" do
    before(:all) do
        payload = { email: "ana@mail.com", password: "teste652"}
        usuario = Sessions.new.login(payload)
        @locador_id = usuario.parsed_response["_id"]
    end


    context "Solicitar locação" do

        before(:all) do

            usuario = Sessions.new.login({email: "joe@mail.com", password: "teste652"})
            dono_equipo_id = usuario.parsed_response["_id"]

            equipo = {
                thumbnail: Helpers::get_thumb("fender-sb.jpg"),
                name: "Fender Strato",
                category: "Cordas",
                price: 185
            }
            MongoDB.new.remove_equipo(equipo[:name], dono_equipo_id)
            
            equipo_criado = Equipos.new.create(equipo, dono_equipo_id)
            equipo_id = equipo_criado.parsed_response["_id"]

            @resultado = Equipos.new.booking(equipo_id, @locador_id)
        end

        it "Deve retornar 200" do
            expect(@resultado.code).to eql 200
        end
    end
end