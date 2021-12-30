require_relative('../lib/app')

RSpec.describe 'how-many' do
  context 'displays usage text' do
    it 'when no args specified' do
      expect{ system('./how-many') }.to output(a_string_including('Usage:')).to_stdout_from_any_process
    end

    it 'when --help is specified' do
      expect{ system('./how-many --help') }.to output(a_string_including('Usage:')).to_stdout_from_any_process
    end

    it 'when --h is specified' do
      expect{ system('./how-many -h') }.to output(a_string_including('Usage:')).to_stdout_from_any_process
    end
  end

  context 'correctly performs calculations' do
    it 'when correct args passed' do
      expect{ system('./how-many seconds in 1 hour') }.to output("3600.0\n").to_stdout_from_any_process
    end
  end
end
