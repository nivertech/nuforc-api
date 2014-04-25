namespace :history_scraper do
  desc "Run the history scraper"
  task :run => :environment do
    # keys must match db columns names
    months = NUFORCScraper.get_history
    months.each do |month|
      Month.create(month) if month
    end

    # keys must match db columns names
    sightings = NUFORCScraper.get_sightings
    sightings.each do |sighting|
      Sighting.create(sighting) if sighting
    end
  end
end

task :default => 'history_scraper:run'