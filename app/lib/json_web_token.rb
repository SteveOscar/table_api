class JsonWebToken
  # class << self
  #   def encode(payload, exp = 24.hours.from_now)
  #     payload[:exp] = exp.to_i
  #     JWT.encode(payload, Rails.application.secrets.secret_key_base)
  #   end
  #
  #   def decode(token)
  #     body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
  #     HashWithIndifferentAccess.new body
  #   rescue
  #     nil
  #   end
  # end

  # Encodes and signs JWT Payload with expiration
  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # Decodes the JWT with the signed secret
  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end

  # Validates the payload hash for expiration and meta claims
  def self.valid_payload(payload)
    if expired(payload)
      return false
    else
      return true
    end
  end

  # Default options to be encoded in the token
  def self.meta
    {
      exp: 1.year.from_now.to_i,
      iss: 'issuer_name',
      aud: 'client',
    }
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end
