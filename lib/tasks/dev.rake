namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    User.create!(
      name: "admin",
      email: "root@example.com",
      password: "12345678",
      role: "admin",
      introduction: FFaker::Lorem::sentence(30),
      avatar: File.open("#{Rails.root}/public/avatar/user1.jpg")
    )
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
      puts user.name
    end
    puts "have created admin and fake users!"
    puts "now you have #{User.count} users data!"
  end

end


namespace :dev do
  task fake_tweet: :environment do
    Tweet.destroy_all

    30.times do |i|
      Tweet.create!(
        description: FFaker::Tweet.body,
        user: User.all.sample
      )
    end
    puts "have created fake tweets!"
    puts "now you have #{Tweet.count} tweets data!"
  end
end


namespace :dev do
  task fake_reply: :environment do
    Reply.destroy_all

    Tweet.all.each do |tweet|
      3.times do |i|
        tweet.replies.create!(
          comment: FFaker::Lorem.paragraph,
          user: User.all.sample
        )
      end
      tweet.replies_count = 3
      tweet.save
    end
    puts "have created fake replies!"
    puts "now you have #{Reply.count} comments data!"
  end
end
