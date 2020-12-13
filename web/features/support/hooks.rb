Before do
    @alert = Alert.new
    @login_page = LoginPage.new
    @signup_page = SignupPage.new
    @dash_page = DashPage.new
    @equipos_page = EquiposPage.new

    page.current_window.resize_to(1366, 768)

end

After do
  tempShot = page.save_screenshot("logs/tempShot.png")

    # Allure.add_attachment(
    #     name: "Screenchot",
    #     type: Allure::ContentType::PNG,
    #     source: File.open(tempShot)
    # )
  # screenshot = File.open(tempShot, "rb")

  screenshot = File.open(File.join(tempShot), "rb")
  attach(screenshot, 'image/png')
end