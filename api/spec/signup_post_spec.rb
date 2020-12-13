
describe "Post /signup" do
    context "Novo usuario" do
        before(:all) do
            payload = { name: "Pitty", email: "pitty@bol.com", password: "teste123"}
            MongoDB.new.remove_user(payload[:email])

            @resultado = Signup.new.create(payload)
        end

        it "Valida status code" do
            expect(@resultado.code).to eql 200
        end

        it "Valida id do usuário" do
            expect(@resultado.parsed_response["_id"].length).to eql 24
        end
    end

    context "Usuario ja existe" do
        before(:all) do
            payload = { name: "João da silva", email: "joao@bol.com", password: "teste123"}
            MongoDB.new.remove_user(payload[:email])

            Signup.new.create(payload)
            @resultado = Signup.new.create(payload)
        end

        it "Deve retornar 409" do
            expect(@resultado.code).to eql 409
        end

        it "Deve retornar mensagem" do
            expect(@resultado.parsed_response["error"]).to eql "Email already exists :(" 
        end
    end

    exemplos = Helpers::get_fixture("signup")

    exemplos.each do |e|
        context "#{e[:title]}" do

            before(:all) do
                @resultado = Signup.new.create(e[:payload])
            end
    
            it "Valida status code #{e[:code]}" do
                expect(@resultado.code).to eql e[:code]
            end
    
            it "Valida id do usuário" do
                expect(@resultado.parsed_response["error"]).to eql e[:error]
            end
        end
    end 
end