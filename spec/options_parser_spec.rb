require('spec_helper')
require_relative('../lib/options_parser')

RSpec.describe HowMany::OptionsParser do
  let(:args) { ['seconds', 'in', '1', 'minute'] }
  let(:args_t) { ['seconds', 'in', '1', 'minute', '-ti'] }
  let(:args_tf) { ['seconds', 'in', '1', 'minute', '--type=f'] }

  describe '.parse' do
    it 'parses arguments' do
      result = described_class.parse(args)
      expect(result.type).to eq("float")
      expect(result.to_units).to eq("second")
      expect(result.operation).to eq("in")
      expect(result.from_units).to eq("minute")
      expect(result.from_number).to eq(1)
    end

    it 'detects integer  output types' do
      result = described_class.parse(args_t)
      expect(result.type).to eq("integer")
    end

    it 'detects float output types' do
      result = described_class.parse(args_tf)
      expect(result.type).to eq("float")
    end

    # context 'displays usage text' do
    #   it 'when no args specified' do
    #     expect { described_class.parse([]) }.to output(/^Usage:/).to_stdout
    #   end

    #   it 'when --help is specified' do
    #     expect { described_class.parse(['--help']) }.to output(/^Usage:/).to_stdout
    #   end

    #   it 'when -h is specified' do
    #     expect { described_class.parse(['-h']) }.to output(/^Usage:/).to_stdout
    #   end
    # end

    # context 'it works' do
    #   it 'it really does' do
    #     expect(8).to eq(8)
    #   end
    # end
  end
end
