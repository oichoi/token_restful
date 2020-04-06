class Product < ApplicationRecord
    mount_uploader :img, PhotoUploader
    validates :title, presence: true, length: { maximum: 100 }
    validates :content, presence: true, length: { maximum: 500 }
    validates :token, inclusion: { in: ["rzBHzJi3RuftqmFwhevESoPg"] }
end
