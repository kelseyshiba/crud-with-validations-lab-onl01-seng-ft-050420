class Song < ApplicationRecord
    # :title :released :release_year :artist_name :genre

    validates :title, presence: true
    validates :title, uniqueness: {scope: [:artist_name, :release_year], message: "cannot have same artist in same year"}
    # validates :release_year, presence: true, if: :released?
    # validate :release_year_valid?, if: :released?
    validates :artist_name, presence: true
    validates :released, inclusion: {in: [true, false]}
    with_options if: :released? do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
          less_than_or_equal_to: Date.today.year
        }
      end

    # def release_year_valid?
    #     release_year != nil && release_year <= Date.today.year
    # end

    def released?
        released      
    end

end
