require "rake"
require "./lib/togglev_bot"

date = Date.today

namespace :toggl do
  task :summary do
    workbook = TogglevBot::WorkBook.new
    workbook.generate(
      :summary,
      from: date.to_s(:db),
      to: date.to_s(:db)
    )
  end

  task :weekly do
    workbook = TogglevBot::WorkBook.new
    workbook.generate(
      :weekly,
      from: date.at_beginning_of_week.to_s(:db),
      to: date.to_s(:db)
    )
  end
end
