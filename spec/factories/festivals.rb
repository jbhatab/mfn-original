FactoryGirl.define do
  factory :festival do
    name 'Infrasound'
    city 'Minneapolis'
    state 'MN'
    latitude '7'
    longitude '8'
    website 'www.infrasound.com'
    facebook 'facebook.com/infrasound'
    zip '55414'
    img_url 'graph.facebook.com/infrasound/picture'
    start_date '2013-05-31'
    end_date '2013-06-02'
    festivaltype 'camping'
    region 'Midwest'
  end
end
