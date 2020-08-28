class Message < ApplicationRecord
    belongs_to :user
    validates :body, presence: true
    ## da iz baze dohvati samo zadnjih 20 poruka
    scope :custom_display, -> { order(:created_at).last(20) }
end
