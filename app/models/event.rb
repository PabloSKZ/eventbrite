class Event < ApplicationRecord
    validates :start_date, presence: true
    validate :not_past_date
    validates :duration, presence: true, numericality: { only_intger: true, greater_than: 0 }
    validate :five_multiple
    validates :title, presence: true, length: { in: 5..140 }
    validates :description, presence: true, length: { in: 20..1000 }
    validates :price, presence: true, numericality: { only_intger: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }

    belongs_to :user
    has_many :users, through: :attendances, dependent: :destroy
    has_many :attendances, dependent: :destroy

    private 

    def not_past_date
        if start_date.past?
            errors.add(:start_date, 'not in past')
        end
    end

    def five_multiple
        unless duration % 5 == 0
            errors.add(:duration, 'only five muliple')
        end
    end
end
