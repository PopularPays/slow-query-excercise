class User < ApplicationRecord
  def find_user
    first_name_to_look_for = ('a'..'z').to_a.shuffle[0,8].join
    email_name_to_look_for = ('a'..'z').to_a.shuffle[0,8].join + "@gmail.com"

    User.where(first_name: first_name_to_look_for).where(email: email_name_to_look_for).where('created_at > ?', Time.now - 2.weeks)
  end

  def find_user
    first_name_to_look_for = ('a'..'z').to_a.shuffle[0,8].join
    email_name_to_look_for = ('a'..'z').to_a.shuffle[0,8].join

    User.where('created_at > ?', Time.now - 2.weeks)
  end

  def self.create_records
    1000.times do
      users = []
      1000.times do
        users << {
          first_name: ('a'..'z').to_a.shuffle[0,8].join,
          email: ('a'..'z').to_a.shuffle[0,8].join + "@gmail.com"
        }
      end

      User.transaction do
        User.import([:first_name, :email], users)
      end
    end
  end
end
