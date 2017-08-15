require("pg")

class Bounty

  attr_accessor(:name, :species, :homeworld, :value)
  attr_reader(:id)

  def initialize( bounty_hunter )
    @id = bounty_hunter["id"].to_i() if bounty_hunter["id"]
    @name = bounty_hunter["name"]
    @species = bounty_hunter["species"]
    @homeworld = bounty_hunter["homeworld"]
    @value = bounty_hunter["value"].to_i()
  end

  def save()
    db = PG.connect({ dbname: "bounty", host: "localhost" })
    sql = "
      INSERT INTO bounty_available
      (name, species, homeworld, value)
      VALUES
      ($1, $2, $3, $4)
      returning *;
    "
    values = [@name, @species, @homeworld, @value]
    db.prepare("save", sql)

    pg_result = db.exec_prepared("save", values)
    saved_order_hash = pg_result[0]
    id_string = saved_order_hash["id"]
    @id = id_string.to_i

    db.close()
  end

  def Bounty.all()
    db = PG.connect({ dbname: "bounty", host: "localhost"})
    sql = "SELECT * FROM bounty_available;"
    values = []
    db.prepare("all", sql)
    hunters = db.exec_prepared("all", values)
    db.close()
    return hunters
  end

  def Bounty.delete_all()
    db = PG.connect({ dbname: "bounty", host: "localhost" })
    sql = "DELETE FROM bounty_available;"
    values = []
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all", values)
    db.close()
  end

  def delete()
    db = PG.connect({ dbname: "bounty", host: "localhost" })
    sql = "
      DELETE FROM bounty_available
      WHERE id = $1;
    "

    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({ dbname: "bounty", host: "localhost" })
    sql = "
      UPDATE bounty_available
      SET
      (name, species, homeworld, value)
      =
      ($1, $2, $3, $4)
      WHERE id = $5;
    "
    values = [@name, @species, @homeworld, @value, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

end
