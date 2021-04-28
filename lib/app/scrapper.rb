require "rubygems"
require "nokogiri"
require "open-uri"
require "json"

class Scrapper
  def get_townhall_email_city(townhall_url)
    mailS = []
    nameS = []

    townhall_url.each { |url|
      page = Nokogiri::HTML(URI.open(url))

      page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each { |mail|
        mailS.push(mail.text)
      }

      page.xpath("/html/body/div/main/section[1]/div/div/div/h1").each { |a|
        name = a.text[0, a.text.size - 8]
        nameS.push(name)
      }
    }
    repertoire = []
    repertoire = nameS.zip(mailS).map! { |k, v| { k => v } }

    puts repertoire
    case choix
    when 1
      save_as_JSON(repertoire)
    when 2
      save_as_spreadsheet(repertoire)
    when 3
      save_as_csv(repertoire)
    end
    return repertoire
  end

  def get_townhall_urls(choix)
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

    townhall_url = []
    page.xpath('//a[@class="lientxt"]/@href').each { |a|
      townhall_url.push("https://www.annuaire-des-mairies.com/" + a)
    }
    return townhall_url
  end

  def save_as_JSON(repertoire)
    File.open("db/emails.json", "w") do |f|
      f.write(JSON.pretty_generate(repertoire))
    end
  end

  def save_as_spreadsheet(repertoire)
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1gHCelf3S2b-0sLWBbKXn4k5_c0kVI30HXOraqOfGL7k").worksheets[0]
  end

  def save_as_csv(repertoire)
    File.write("db/emails.csv", repertoire)
    #end
  end

  def perform
    puts "Faites votre choix :"
    print "1:json / 2:google /3: csv >>> "
    choix = gets.chomp.to_i
    townhall_url = get_townhall_urls(choix)
    get_townhall_email_city(townhall_url)
  end
end
