require 'date'
require 'time'
require 'calculator'

RSpec.describe HowMany::Calculator do
  describe '#how_many_till' do
    it 'calculates how many minutes till a time 1 hour into the future' do
      t = Time.now + 3600
      result = described_class.how_many_till("minute", t, return_type: "integer")
      expect(result).to eq(60)
    end

    it 'calculates how many seconds till a time 10 minutes into the future' do
      t = Time.now + 600
      result = described_class.how_many_till("minute", t, return_type: "integer")
      expect(result).to eq(10)
    end

    it 'calculates how many seconds till a certain date in the future' do
      t = Time.now + 3 * 3600 * 24
      result = described_class.how_many_till("day", t, return_type: "integer")
      expect(result).to eq(3)
    end

    it 'fails when a date or time in the past is specified' do
      t = Time.now - 24 * 2600
      expect { described_class.how_many_till("second", t) }.to raise_error(HowMany::DateTimeInPastError)
    end

    it "fails when a pluralised unit is passed in" do
      t = Time.now + 3600
      expect { described_class.how_many_till("seconds", t) }.to raise_error(HowMany::UnrecognisedUnitError)
    end

    it "fails when an unrecognised unit is passed in" do
      t = Time.now + 3600
      expect { described_class.how_many_till("miles", t) }.to raise_error(HowMany::UnrecognisedUnitError)
    end
  end

  describe '#how_many_in' do
    it 'calculates how many seconds in 1 minute' do
      result = described_class.how_many_in(1, "minute", "second")
      expect(result).to eq(60.0)
      expect(result).to be_an_instance_of(Float)
    end

    it 'calculates how many minutes in 2 hours' do
      expect(described_class.how_many_in(2, "hour", "minute")).to eq(120.0)
    end

    it 'calculates how many hours in 30 minutes' do
      expect(described_class.how_many_in(30, "minute", "hour")).to eq(0.5)
    end

    it 'returns a Float when specified' do
      result = described_class.how_many_in(1, "minute", "second", return_type: "float")
      expect(result).to be_an_instance_of(Float)
    end

    it 'returns an Integer when specified' do
      result = described_class.how_many_in(1, "minute", "second", return_type: "integer")
      expect(result).to be_an_instance_of(Integer)
    end

    it "fails when a pluralised unit is passed in" do
      expect { described_class.how_many_in(1, "minutes", "seconds") }.to raise_error(HowMany::UnrecognisedUnitError)
    end

    it "fails when a unrecognised unit is passed in" do
      expect { described_class.how_many_in(1, "metres", "furlong") }.to raise_error(HowMany::UnrecognisedUnitError)
    end
  end
end
