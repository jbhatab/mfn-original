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
    @line1 = @festival.festival_year.event.address.line1
    @line2 = @festival.festival_year.event.address.line2
    @city = @festival.festival_year.event.address.city
    @state = @festival.festival_year.event.address.state
    @country = @festival.festival_year.event.address.country
    @zip = @festival.festival_year.event.address.zip
    @region = @festival.festival_year.event.address.region
    @festivaltype = @festival.festival_year.event.event_type
    

    @start_at = @festival.festival_year.event.start_at
    @end_at = @festival.festival_year.event.end_at
    


    mail to: "jbhatab@gmail.com", subject: 'festival submision'
  end
end
