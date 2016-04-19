task :foodcritic do
  system('foodcritic .')
end

task :rubocop do
  system('rubocop')
end

task :rspec do
  system('rspec')
end

task default: %w(ci)

task ci: %w(foodcritic rubocop rspec)
