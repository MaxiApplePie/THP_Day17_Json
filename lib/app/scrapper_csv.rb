require "rubygems"
require "nokogiri"
require "open-uri"
require "csv"

class Scrapper
  def fonction()
    mailS = []
    nameS = []

    repertoire = [
      { "ABLEIGES" => "mairie.ableiges95@wanadoo.fr" },
      { "AINCOURT" => "mairie.aincourt@wanadoo.fr" },
      { "AMBLEVILLE" => "mairie.ambleville@wanadoo.fr" },
      { "AMENUCOURT" => "mairie.amenucourt@wanadoo.fr" },
      { "ANDILLY" => "mairie.andilly@wanadoo.fr" },
      { "ARGENTEUIL" => "christian.bournery@ville-argenteuil.fr" },
      { "ARNOUVILLE-LES-GONESSE" => "webmaster@villedarnouville.com" },
      { "ARRONVILLE" => "arronville@wanadoo.fr" },
      { "ARTHIES" => "mairie-arthies-95@wanadoo.fr" },
      { "ASNIERES-SUR-OISE" => "herve.pellin@ville-asnieres-sur-oise.fr" },
      { "ATTAINVILLE" => "mairie@attainville.fr" },
      { "AUVERS-SUR-OISE" => "communication@auvers-sur-oise.com" },
    ]

    puts repertoire
    save_as_csv(repertoire)
    return repertoire
  end

  #  def save_as_JSON(repertoire)
  #    File.open("db/emails.json", "w") do |f|
  #      f.write(JSON.pretty_generate(repertoire))
  #    end
  #  end

  def save_as_csv(repertoire)
    File.open("db/emails.csv", "w") do |f|
      f.write(CSV.read(repertoire))
      #File.write("db/emails.csv", repertoire)
    end
  end

  def perform
    fonction
  end
end
