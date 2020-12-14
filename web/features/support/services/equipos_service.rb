require_relative "base_service"

class EquiposService < BaseService

    def create(equipo, user_id)
        payload = equipo
        
        return self.class.post(
                "/equipos",
                body: payload,
                headers: {
                    "user_id": user_id
                }
            )
    end

    def booking(equipo_id, locador_id)
        return self.class.post(
            "/equipos/#{equipo_id}/bookings",
            body: { date: Time.now.strftime("%d/%m/%Y") }.to_json,
            headers: {
                "content-type": "application/json",
                "user_id": locador_id
            }
        )
    end
end