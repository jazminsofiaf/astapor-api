class InscriptionParser
  def parse_codes(codes)
    response = []
    codes.each do |code|
      response.push('cupo': code)
    end
    response
  end
end
