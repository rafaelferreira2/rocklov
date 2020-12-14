
describe "POST /sessions" do

    context "Login com sucesso" do

        before(:all) do
            payload = { email: "teste@mail.com", password: "teste652"}
            @resultado = Sessions.new.login(payload)
        end

        it "Valida status code 200" do
            expect(@resultado.code).to eql 200
        end

        it "Valida id do usuário" do
            expect(@resultado.parsed_response["_id"].length).to eql 24
        end
    end

    exemplos = [
        {
            title: "Senha incorreta",
            payload: { email: "teste@mail.com", password: "123123"},
            code: 401,
            error: "Unauthorized"
        },
        {
            title: "Usuario não existe",
            payload: { email: "404@mail.com", password: "123123"},
            code: 401,
            error: "Unauthorized"
        },
        {
            title: "Email em branco",
            payload: { email: "", password: "123123"},
            code: 412,
            error: "required email"
        },
        {
            title: "Sem o campo email",
            payload: { password: "123123"},
            code: 412,
            error: "required email"
        },
        {
            title: "Senha em branco",
            payload: { email: "teste@mail.com", password: ""},
            code: 412,
            error: "required password"
        },
        {
            title: "Sem o campo senha",
            payload: { email: "teste@mail.com"},
            code: 412,
            error: "required password"
        }
    ]

    # exemplos = Helpers::get_fixture("login")

    exemplos.each do |e|
        context "#{e[:title]}" do

            before(:all) do
                @resultado = Sessions.new.login(e[:payload])
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