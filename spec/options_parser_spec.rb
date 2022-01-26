# frozen_string_literal: true

require('spec_helper')
require('options_parser')

RSpec.describe HowMany::OptionsParser do
  let(:args_in) { %w[seconds in 1 minute] }
  let(:args_till) { %w[seconds till 10:00pm] }
  let(:args_in_t) { %w[seconds in 1 minute -ti] }
  let(:args_in_tf) { %w[seconds in 1 minute --type=f] }

  describe '.parse' do
    it 'detects integer output type' do
      result = described_class.parse(args_in_t)
      expect(result.type).to eq('integer')
    end

    context 'detects float output type' do
      it 'when -t flag specified' do
        result = described_class.parse(args_in_tf)
        expect(result.type).to eq('float')
      end

      it 'when no -t flag specified' do
        result = described_class.parse(args_in)
        expect(result.type).to eq('float')
      end
    end

    context 'parses arguments' do
      it 'when in operation specified' do
        result = described_class.parse(args_in)
        expect(result.type).to eq('float')
        expect(result.to_units).to eq('second')
        expect(result.operation).to eq('in')
        expect(result.from_units).to eq('minute')
        expect(result.from_number).to eq(1)
      end
    end

    context 'parses arguments' do
      it 'when till operation specified' do
        result = described_class.parse(args_till)
        expect(result.to_units).to eq('second')
        expect(result.operation).to eq('till')
        expect(result.till_time).to eq(Time.parse('10:00pm'))
      end
    end
  end
end
