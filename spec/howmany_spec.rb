require_relative('../lib/app')

RSpec.describe 'how-many' do
  describe 'correctly performs calculations' do
    it 'when correct args passed' do
      expect{ system('./how-many seconds in 1 hour') }.to output("3600.0\n").to_stdout_from_any_process
    end
  end
end
