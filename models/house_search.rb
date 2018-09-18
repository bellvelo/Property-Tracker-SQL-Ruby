require('pg')

class HouseSearch

attr_accessor :address, :value, :beds, :year
attr_reader :id

def initialize(options)
  @id = options["id"].to_i if options["id"]
  @address = options["address"]
  @value = options["value"].to_i
  @beds = options["beds"].to_i
  @year = options["year"].to_i
end

def save()  # CREATE #
  db = PG.connect({ dbname: "property_tracker", host: "localhost" })  # this connects the ruby file to the db
  sql =
  "INSERT INTO houses (address, value, beds, year)
  VALUES ($1, $2, $3, $4)
  RETURNING *"
  values = [@address, @value, @beds, @year]

  db.prepare("save", sql)
  @id = db.exec_prepared("save", values)[0]["id"].to_i  # adds an id to the new record and the object.
  db.close()
end

def HouseSearch.all() # READ #
  db = PG.connect({ dbname: "property_tracker", host: "localhost" })  # this connects the ruby file to the db
  sql = "SELECT * FROM houses"

  db.prepare("all", sql)
  search = db.exec_prepared("all") # returns an array of hashes
  db.close()

  return search.map {|hash| HouseSearch.new(hash)} # coverts the array of hashes into an array of objects
end

def update # UPDATE #
  db = PG.connect({ dbname: "property_tracker", host: "localhost" })  # this connects the ruby file to the db
  sql =
  "UPDATE houses SET (address, value, beds, year)
  = ($1, $2, $3, $4)
  WHERE id = $5"
  values = [@address, @value, @beds, @year, @id]

  db.prepare("update", sql)
  db.exec_prepared("update", values)
  db.close()
end

def delete  # DELETE #
  db = PG.connect({ dbname: "property_tracker", host: "localhost" })  # this connects the ruby file to the db
  sql = "DELETE FROM houses WHERE id = $1"
  values = [@id]

  db.prepare("delete_one", sql)
  db.exec_prepared("delete_one", values)
  db.close
end

def HouseSearch.delete_all()  # DELETE #
  db = PG.connect({ dbname: "property_tracker", host: "localhost" })  # this connects the ruby file to the db
  sql = "DELETE FROM houses"

  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all")
  db.close
end

def HouseSearch.find_by_id(id)
  db = PG.connect({ dbname: "property_tracker", host: "localhost" })  # this connects the ruby file to the db
  sql = "SELECT * FROM houses WHERE id = $1"
  values = [id]

  db.prepare("find_by_id", sql)
  search_by_id = db.exec_prepared("find_by_id", values) # outputs an array of hashes
  db.close()

  found_property_hash = search_by_id[0] # returns the first hash in the array
  return HouseSearch.new(found_property_hash) # converts the array of hashes, into an array of objects (which we can call methods on)
end

def HouseSearch.find_by_address(address)
  db = PG.connect({ dbname: "property_tracker", host: "localhost" })  # this connects the ruby file to the db
  sql = "SELECT * FROM houses WHERE address = $1"
  values = [address]

  db.prepare("find_by_address", sql)
  search_by_address = db.exec_prepared("find_by_address", values) # outputs an array of hashes
  db.close()

  found_property_hash = search_by_address[0] # returns the first hash in the array
  return HouseSearch.new(found_property_hash)# converts the array of hashes, into an array of objects (which we can call methods on)
end



# this is th end
end
