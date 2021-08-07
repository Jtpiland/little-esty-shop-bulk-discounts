class NagerService
  def holiday
    endpoint = "https://date.nager.at/api/v3/NextPublicHolidays/US"
    get_data(endpoint)
  end

  def get_data(endpoint)
   response = Faraday.get(endpoint)
   JSON.parse(response.body, symbolize_names: true)
  end
end
