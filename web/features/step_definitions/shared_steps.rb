  
Então('sou redirecionado para o Dashboard') do
    expect(@dash_page.on_dash?).to be true
end

Então('vejo a mensagem de alerta: {string}') do |msg_esperada|
    expect(@alert.alert_dark).to eql msg_esperada
end

Então('deve conter a mensagem de alerta: {string}') do |msg_esperada|
    expect(@alert.alert_dark).to have_text msg_esperada
end