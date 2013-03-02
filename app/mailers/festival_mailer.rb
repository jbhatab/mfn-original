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
    @city = @festival.city
    @state = @festival.state
    @lat = @festival.lat
    @long = @festival.long
    @start_date = @festival.start_date
    @website = @festival.website
    @facebook = @festival.facebook
    @region = @festival.region
    @festivaltype = @festival.festivaltype
    @end_date = @festival.end_date
    @address = @festival.address
    @zip = @festival.zip


    mail to: "jbhatab@gmail.com", subject: 'festival submision'
  end
end
