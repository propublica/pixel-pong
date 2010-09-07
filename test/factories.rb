Factory.define :stat do |s|
  s.url { "http://#{Faker::Internet.domain_name()}/#{Faker::Internet.domain_word()}?t=#{Faker::Internet.domain_word}" }
  s.hits { (rand * 10).to_i ** (rand * 10).to_i }
end