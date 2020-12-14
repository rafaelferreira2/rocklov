require_relative "base_service"

class SessionService < BaseService

    def get_user_id(email, senha)
        payload = { email: email, password: senha }
        result =  self.class.post(
                "/sessions",
                body: payload.to_json,
                headers: {
                    "Content-Type": "application/json"
                }
            )

        return result.parsed_response["_id"]
    end
end