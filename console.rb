require("pry-byebug")
require_relative("models/bounty")

Bounty.delete_all()

bounty1 = Bounty.new({
  "name" => "Boba Fett",
  "species" => "Human",
  "homeworld" => "Kamino",
  "value" => "10000"
  })

bounty2 = Bounty.new({
  "name" => "Greedo",
  "species" => "Rodian",
  "homeworld" => "Tatooine",
  "value" => "5000"
  })

bounty1.save()
bounty2.save()

bounties = Bounty.all()

bounties_list = bounties.map { |bounty_hash| Bounty.new(bounty_hash) }

binding.pry

nil
