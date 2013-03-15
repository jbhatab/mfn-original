class FestivalMailer < ActionMailer::Base
  default from: "jbhatab@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.festival_mailer.submit_festival.subject
  #
  def submit_festival(festival)
    @festival = festival
    @name = @festival.name
    @website = @festival.website
    @facebook = @festival.facebook

    @city = @festival.event.city
    @state = @festival.event.state
    @lat = @festival.event.latitude
    @long = @festival.event.longitude
    @region = @festival.event.region
    @festivaltype = @festival.event.festivaltype
    @address = @festival.event.address
    @zip = @festival.event.zip

    @start_date = @festival.event.eventdates.select('start')
    @end_date = @festival.event.end_date
    


    mail to: "jbhatab@gmail.com", subject: 'festival submision'
  end
end
