require('pry')
require_relative('./models/house_search')

# HouseSearch.delete_all()

house1 = HouseSearch.new({
  "address" => "10 High Street",
  "value" => 500000,
  "beds" => 3,
  "year" => 1930
})
house1.save()
# house1.value = 800
# house1.update()

house2 = HouseSearch.new({
  "address" => "45 Mulholland Drive",
  "value" => 1000000,
  "beds" => 6,
  "year" => 1912
})
house2.save()

# house2.delete()

all_properties = HouseSearch.all()
id_search = HouseSearch.find_by_id(house1.id)
address_search = HouseSearch.find_by_address(house2.address)

binding.pry
nil
