require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'helper methods' do
    describe '#format_runtime(runtime)' do
      it 'formats a runtime in minutes to a string with hours and minutes' do
        expect(format_runtime(100)).to eq("1h 40m")
      end
    end

    describe '#format_genres(genres)' do
      it 'formats an array of genre strings to a single string seperated by commas' do
        genres = ['Comedy', 'Drama', 'Horror']
        expect(format_genres(genres)).to eq("Comedy, Drama, Horror")
      end
    end

    describe '#count_reviews(reviews)' do
      it 'counts the number of reviews hashes in a single reviews array' do
        reviews = [{a: "a"}, {b: "b"}, {c: "c"}]
        expect(count_reviews(reviews)).to eq(3)
      end
    end
  end
end
